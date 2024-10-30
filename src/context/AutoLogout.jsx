import React, { useContext, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { StoreContext } from "../context/StoreContext";

const AutoLogout = () => {
  const navigate = useNavigate();
  const logoutTime = 3 * 60 * 60 * 1000;
  const { setIsAuthenticated } = useContext(StoreContext);

  useEffect(() => {
    const loginTime = localStorage.getItem("loginTime");

    // Nếu chưa có 'loginTime', lưu thời gian đăng nhập hiện tại
    if (!loginTime) {
      localStorage.setItem("loginTime", Date.now());
    }

    // Thiết lập interval để kiểm tra thời gian đăng nhập
    const interval = setInterval(() => {
      const currentTime = Date.now();
      const storedLoginTime = localStorage.getItem("loginTime");

      if (storedLoginTime && currentTime - storedLoginTime >= logoutTime) {
        handleLogout(); // Thực hiện đăng xuất nếu quá thời gian
      }
    }, 1001); // Kiểm tra mỗi giây

    // Dọn dẹp interval khi component bị unmount
    return () => clearInterval(interval);
  }, []);

  const handleLogout = () => {
    // Xóa thông tin đăng nhập
    localStorage.removeItem("access_token");
    localStorage.removeItem("role");
    localStorage.removeItem("loginTime");
    localStorage.removeItem("id");
    setIsAuthenticated(false);

    // Điều hướng về trang đăng nhập
    navigate("/");
  };
};

export default AutoLogout;
