const conn = require('../utils/db');
const crypto = require('crypto-js');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('NHANVIEN').withSchema(schema)
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .select('NHANVIEN.*', 'DONVI.TENDV');
    },

    async single(id) {
      const employees = await db('NHANVIEN').withSchema(schema)
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .select('NHANVIEN.*', 'DONVI.TENDV')
        .where('ID_NHANVIEN', id);
      if (employees.length === 0) {
        return null;
      }
      let result = employees[0];

      const secretKey = process.env.DB_SECRET_ENCRYPTION;
      try {
        const salary = await db.raw('select DECRYPTSALARY_FUNC() AS LUONGCA from dual');
        if (salary[0] && salary[0].LUONGCA) {
          const luongca = salary[0].LUONGCA;
          const bytes = crypto.AES.decrypt(luongca, secretKey);
          console.log('secretKey :>> ', secretKey);
          console.log('luongca :>> ', luongca);
          console.log('bytes :>> ', bytes);
          result.LUONGCA = bytes.toString(crypto.enc.Utf8);
          console.log('result.LUONGCA :>> ', result.LUONGCA);
        }
      } catch (error) {
        console.log('error :>> ', error);
      }
      try {
        const subSalary = await db.raw('select DECRYPTSUBSALARY_FUNC() AS PHUCAP from dual');
        if (subSalary[0] && subSalary[0].PHUCAP) {
          const phucap = subSalary[0].PHUCAP;
          const bytes = crypto.AES.decrypt(phucap, secretKey);
          result.PHUCAP = bytes.toString(crypto.enc.Utf8);
          console.log('object :>> ', result.PHUCAP);
        }
      } catch (error) {
        console.log('error :>> ', error);
      }
      return result;
    },

    async add(employee) {
      const { PASSWORD, ...info } = employee;
      await db('NHANVIEN').withSchema(schema)
        .insert({
          ...info,
          NGAYSINH: db.raw(`TO_DATE('${info.NGAYSINH}', 'yyyy/mm/dd')`)
        });

      // Encrypt salary
      const secretKey = process.env.DB_SECRET_ENCRYPTION;
      if (employee.LUONGCA) {
        const luongEncryped = crypto.AES.encrypt(employee.LUONGCA, secretKey).toString();
        employee.LUONGCA = luongEncryped;
      }
      if (employee.PHUCAP) {
        const phucapEncryped = crypto.AES.encrypt(employee.PHUCAP, secretKey).toString();
        employee.PHUCAP = phucapEncryped;
      }

      const { VAITRO, DONVI } = info;
      await db.raw(`BEGIN create_user('${VAITRO}', '${PASSWORD}'); END;`);
      await db.raw(`
        DECLARE
        role_name varchar(50);
        BEGIN
            SELECT VAITRO INTO role_name FROM DONVI WHERE ID_DONVI = '${DONVI}';
            IF role_name IS NOT NULL THEN
              grant_role_to_role_or_user(role_name, '${VAITRO}');
            END IF;
        END;`);
    },

    async update(id, employee) {
      // get previous role
      const old = await db('NHANVIEN').withSchema(schema)
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .select('DONVI.VAITRO')
        .where('NHANVIEN.ID_NHANVIEN', id)
        .first();
      const oldRole = old.VAITRO;

      // Encrypt salary
      const secretKey = process.env.DB_SECRET_ENCRYPTION;
      if (employee.LUONGCA) {
        const luongEncryped = crypto.AES.encrypt(employee.LUONGCA, secretKey).toString();
        employee.LUONGCA = luongEncryped;
      }
      if (employee.PHUCAP) {
        const phucapEncryped = crypto.AES.encrypt(employee.PHUCAP, secretKey).toString();
        employee.PHUCAP = phucapEncryped;
      }

      // Update
      await db('NHANVIEN').withSchema(schema)
        .where('ID_NHANVIEN', id)
        .update({
          ...employee,
          NGAYSINH: db.raw(`TO_DATE('${employee.NGAYSINH}', 'yyyy/mm/dd')`)
        });

      const { VAITRO, DONVI } = employee;
      // Change role
      await db.raw(`
        DECLARE
        role_name varchar(50);
        BEGIN
            SELECT VAITRO INTO role_name FROM DONVI WHERE ID_DONVI = '${DONVI}';
            IF role_name IS NOT NULL THEN
              revoke_role('${oldRole}', '${VAITRO}');
              grant_role_to_role_or_user(role_name, '${VAITRO}');
            END IF;
        END;`);
    },

    delete(id) {
      return db('NHANVIEN').withSchema(schema)
        .where('ID_NHANVIEN', id)
        .del();
    },

    doctors() {
      return db('NHANVIEN').withSchema(schema)
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .select('NHANVIEN.ID_NHANVIEN', 'NHANVIEN.TENNV')
        .where('DONVI.TENDV', 'like', 'Khoa%');
    },
    salemen() {
      return db('NHANVIEN').withSchema(schema)
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .select('NHANVIEN.ID_NHANVIEN', 'NHANVIEN.TENNV')
        .where('DONVI.TENDV', 'like', '%bán thuốc%');
    },
    cashiers() {
      return db('NHANVIEN').withSchema(schema)
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .select('NHANVIEN.ID_NHANVIEN', 'NHANVIEN.TENNV')
        .where('DONVI.TENDV', 'like', '%tài vụ%');
    },

    async hasQuanLyRole(user) {
      const res = await db({ d1: 'DBA_ROLE_PRIVS' })
        .join({ d2: 'DBA_ROLE_PRIVS' }, 'd1.GRANTED_ROLE', 'd2.GRANTEE')
        .where('d1.GRANTEE', user)
        .where('d2.GRANTED_ROLE', 'NHANVIEN_QUANLY')
        .count('*', { as: 'COUNT' });

      const { COUNT } = res[0];
      return COUNT > 0;
    },

    async hasAllowLoginRole(user) {
      const res = await db('DBA_ROLE_PRIVS')
        .where('GRANTEE', user)
        .where('GRANTED_ROLE', 'ALLOW_CONNECT')
        .count('*', { as: 'COUNT' });
      const { COUNT } = res[0];

      return COUNT > 0;
    },
    toggleLoginRole(user, allow) {
      if (allow) {
        return db.raw(`GRANT ALLOW_CONNECT TO ${user}`);
      }
      return db.raw(`REVOKE ALLOW_CONNECT FROM ${user}`);
    },


    async hasTaiVuRole(user) {
      const res = await db({ d1: 'DBA_ROLE_PRIVS' })
        .where('GRANTEE', user)
        .where('GRANTED_ROLE', 'NHANVIEN_TAIVU')
        .count('*', { as: 'COUNT' });
      const { COUNT } = res[0];
      return COUNT > 0;
    },
    async hasUpdateServicePriceRole(user) {
      const res = await db('DBA_ROLE_PRIVS')
        .where('GRANTEE', user)
        .where('GRANTED_ROLE', 'ALLOW_UPDATE_SERVICE_PRICE')
        .count('*', { as: 'COUNT' });
      const { COUNT } = res[0];
      return COUNT > 0;
    },
    toggleUpdateServicePriceRole(user, allow) {
      if (allow) {
        return db.raw(`GRANT ALLOW_UPDATE_SERVICE_PRICE TO ${user}`);
      }
      return db.raw(`REVOKE ALLOW_UPDATE_SERVICE_PRICE FROM ${user}`);
    },
  }
};