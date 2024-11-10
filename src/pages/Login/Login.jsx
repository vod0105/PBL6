import React, { useState, useContext } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import "../../styles/Login.css";
import { Link } from "react-router-dom";
import { StoreContext } from "../../context/StoreContext";

const Login = ({ url }) => {
  const [numberPhone, setnumberPhone] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const navigate = useNavigate();
  const { setIsAuthenticated, setUserData, setIdU } = useContext(StoreContext);

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post(`${url}/api/v1/auth/login`, {
        numberPhone,
        password,
      });

      console.log("REsponse OWNER:", response);
      const access_token = response.data.data.token;
      const role = response.data.data.roles[0];
      const id = response.data.data.id;
      localStorage.setItem("access_token", access_token);
      localStorage.setItem("role", role);
      localStorage.setItem("id", id);

      setIsAuthenticated(true);

      setUserData(role);

      // console.log("userData", userData);
      if (role === "ROLE_ADMIN") console.log("Vao if role admin ");
      else if (role === "ROLE_OWNER") navigate("/owner/dashboard");
    } catch (err) {
      setError(
        "Đăng nhập không thành công. Vui lòng kiểm tra lại tên người dùng và mật khẩu."
      );
    }
  };

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
            <form onSubmit={handleSubmit}>
              <input
                type="text"
                placeholder="Phone"
                value={numberPhone}
                onChange={(e) => setnumberPhone(e.target.value)}
                required
              />
              <input
                type="password"
                placeholder="PASSWORD"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
              <button className="opacity" type="submit">
                SUBMIT
              </button>
            </form>
            {error && <p className="error-message">{error}</p>}
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
