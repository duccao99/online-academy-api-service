const nodemailer = require("nodemailer");

// let testAccount = await nodemailer.createTestAccount();
const user = process.env.NODE_MAILER_EMAIL;
const pass = process.env.NODE_MAILER_PASSWORD;
let transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 587,
  secure: false,
  auth: {
    user: user,
    pass: pass,
  },
  tls: {
    rejectUnauthorized: false,
  },
});

module.exports = {
  sendOTP: (email, link_otp) => {
    const mailOptions = {
      from: `Online Academy API Service ${user}`,
      to: `${email}`,
      subject: "Verify your email!",
      text: `Please click the link to verify you email: ${link_otp}`,
    };
    transporter.sendMail(mailOptions, (er, info) => {
      if (er) {
        console.log(er);
      } else {
        console.log(info);
      }
    });
  },

  sendOTPWithThirdPartySignIn: (email, link_otp, password_message) => {
    const mailOptions = {
      from: `Online Academy API Service ${user}`,
      to: `${email}`,
      subject: "Verify your email!",
      text: `Your current password is: ${password_message}\nPlease Click the link to verify you email: ${link_otp}`,
    };

    transporter.sendMail(mailOptions, (er, info) => {
      if (er) {
        console.log(er);
      } else {
        console.log(info);
      }
    });
  },
};
