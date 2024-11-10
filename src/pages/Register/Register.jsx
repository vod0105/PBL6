import React from "react";
import "../../styles/Login.css";
const Register = ({ url }) => {
  return (
    <div>
      <div>
        <section className="container">
          <div className="login-container">
            <div className="circle circle-one"></div>
            <div className="form-container">
              <img
                src="https://raw.githubusercontent.com/hicodersofficial/glassmorphism-login-form/master/assets/illustration.png"
                alt="illustration"
                className="illustration"
              />
              <h1 className="opacity">REGISTER</h1>
              <form>
                <input type="text" placeholder="USERNAME" />
                <input type="password" placeholder="PASSWORD" />
                <input type="password" placeholder="CONFIRMPASSWORD" />
                <button className="opacity">SUBMIT</button>
              </form>
              <div className="register-forget opacity">
                <a href="/">LOGIN</a>
                <a href="aa">FORGOT PASSWORD</a>
              </div>
            </div>
            <div className="circle circle-two"></div>
          </div>
          <div className="theme-btn-container"></div>
        </section>
      </div>
    </div>
  );
};

export default Register;
