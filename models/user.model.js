const db = require("../config/db");
const tbl_users = `users`;

const studentModel = {
  all() {
    const sql = `select *
    from ${tbl_users} u
    ;
    `;
    return db.load(sql);
  },
  async detail(user_id) {
    const sql = `select *
      from ${tbl_users} u

      and u.user_id = ${user_id};`;
    const data = await db.load(sql);

    return data[0];
  },

  add(entity) {
    return db.add(entity, tbl_users);
  },
  del(condition) {
    return db.del(condition, tbl_users);
  },
  edit(entity, condition) {
    return db.edit(entity, condition, tbl_users);
  },

  async detailByUserName(username) {
    const sql = `select * from ${tbl_users} u where u.user_name = '${username}'`;
    const ret = await db.load(sql);
    return ret[0];
  },
  patchRFToken(id, rfToken) {
    const entity = {
      rfToken: rfToken,
    };
    const condition = {
      user_id: id,
    };
    return db.edit(entity, condition, tbl_users);
  },
  async isValidRFToken(userId, rfToken) {
    const sql = `select * from ${tbl_users} 
      where user_id = ${userId}
       and rfToken = '${rfToken}' `;
    const list = await db.load(sql);

    if (list.length > 0) return true;
    return false;
  },

  async singleByEmail(email) {
    const sql = `select * from ${tbl_users} u where u.email = '${email}'`;

    const ret = await db.load(sql);
    return ret[0];
  },
  async getVerifyAccountStatus(email) {
    const sql = `select u.is_verified 
    from ${tbl_users} u
    where u.email = '${email}';`;
    const ret = await db.load(sql);

    if (ret.length === 0) {
      return null;
    }

    if (+ret[0].is_verified === 1) {
      return true;
    } else {
      return false;
    }
  },
  addLinkOTP(link_otp, email) {
    const sql = `update ${tbl_users} u
    set u.otp_verify_url = '${link_otp}'
    where u.email = '${email}';
    `;
    return db.load(sql);
  },
  getLinkOTP(email) {
    const sql = `select u.otp_verify_url 
    from ${tbl_users} u
    where u.email='${email}';`;
    return db.load(sql);
  },
  verifyAccount(link) {
    const sql = `update ${tbl_users} u
    set u.is_verified=true 
    where u.otp_verify_url='https://localhost:3000/${link}';`;
    return db.load(sql);
  },
  async checkPass(email, password) {
    const sql = `select  u.email, u.password
    from ${tbl_users} u
    where u.email='${email}'
    and u.password= '${password}';
    `;
    const ret = await db.load(sql);

    if (ret.length > 0) {
      return true;
    }
    return false;
  },
};

module.exports = studentModel;
