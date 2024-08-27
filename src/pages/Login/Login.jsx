import React from "react";
import "../../styles/Login.css";
import { Link } from "react-router-dom";
const Login = () => {
  return (
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
            <h1 className="opacity">LOGIN</h1>
            <form>
              <input type="text" placeholder="USERNAME" />
              <input type="password" placeholder="PASSWORD" />
              <button className="opacity">SUBMIT</button>
            </form>
            <div className="register-forget opacity">
              <Link to="/register">REGISTER</Link>
              <Link to="#">FORGOT PASSWORD</Link>
            </div>
          </div>
          <div className="circle circle-two"></div>
        </div>
        <div className="theme-btn-container"></div>
      </section>
    </div>
  );
};

export default Login;
