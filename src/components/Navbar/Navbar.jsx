import React, { useContext, useState } from "react";
import "./Navbar.css";
import { assets } from "../../assets/assets";
import { Link, useNavigate, NavLink } from "react-router-dom";
import { StoreContext } from "../../context/StoreContext";
import { useDispatch, useSelector } from 'react-redux';
import { showLoginModal, showRegisterModal } from "../../redux/actions/modalActions";

import cate_1 from "../../assets/navbar/cate_1.png";
import cate_2 from "../../assets/navbar/cate_2.png";
import cate_3 from "../../assets/navbar/cate_3.png";
import cate_4 from "../../assets/navbar/cate_4.png";
import cate_5 from "../../assets/navbar/cate_5.png";
import cate_6 from "../../assets/navbar/cate_6.png";
import cate_7 from "../../assets/navbar/cate_7.png";
import cate_8 from "../../assets/navbar/cate_8.png";


const Navbar = () => {
  // redux modal
  const dispatch = useDispatch();
  const user = useSelector((state) => state.authentication.user);

  const handleShowLogin = () => {
    dispatch(showLoginModal());
  };

  const handleShowRegister = () => {
    dispatch(showRegisterModal());
  };

  const [menu, setMenu] = useState("home");
  const { getTotalCartAmount, setToken, token, setFoodList } = useContext(StoreContext);
  const navigate = useNavigate();
  // const logOut = () => {
  //   localStorage.removeItem("token");
  //   console.log("log out");
  //   setToken("");

  //   navigate("/");

  //   // Đăng xuất thành công
  //   console.log("Logged out successfully");
  // };


  return (
    <div className="navbar">
      <NavLink
        to="/" className="logo"
        end // 'end' đảm bảo rằng chỉ '/' (Trang Chủ) được kích hoạt, không phải các trang khác chứa '/' như '/about'
      >
        <img src={assets.logo} alt="" className="logo-image" />
        {/* <p className="logo-name">LILI</p> */}
      </NavLink>
      <ul className="navbar-menu">
        <NavLink
          to="/"
          className={({ isActive }) => (isActive ? 'active' : '')}
          end
        >
          Trang chủ
        </NavLink>
        <NavLink
          to="/introduce"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Giới thiệu
        </NavLink>
        <NavLink
          to="/category"
          className={({ isActive }) => (isActive ? "active navbar-category" : "navbar-category")}
          onClick={() => setMenu("category")}
        >
          Thực đơn
          <ul className="navbar-category-dropdown">
            <li>
              <img src={cate_1} alt="" />
              <p>MÓN NGON PHẢI THỬ</p>
            </li>

            <li>
              <img src={cate_2} alt="" />
              <p >GÀ GIÒN VUI VẺ</p>
            </li>
            <li>
              <img src={cate_3} alt="" />
              <p>MỲ Ý</p>
            </li>

            <li>
              <img src={cate_4} alt="" />
              <p >GÀ SỐT CAY</p>
            </li>
            <li>
              <img src={cate_5} alt="" />
              <p>BURGER</p>
            </li>

            <li>
              <img src={cate_6} alt="" />
              <p >PHẦN ĂN PHỤ</p>
            </li>
            <li>
              <img src={cate_7} alt="" />
              <p>MÓN TRÁNG MIỆNG</p>
            </li>
            <li>
              <img src={cate_8} alt="" />
              <p >THỨC UỐNG</p>
            </li>
          </ul>
        </NavLink>

        <NavLink
          to="/promotion"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Khuyến mãi
        </NavLink>
        <NavLink
          to="/contact"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Liên hệ
        </NavLink>

        {/* <NavLink
          to="/store"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Cửa hàng
        </NavLink> */}

        <NavLink
          to="/test-store"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Cửa hàng
        </NavLink>

      </ul>
      <div className="navbar-right">
        <Link
          to="/cart"
          className="navbar-search-icon"
        >
          <img src={assets.basket_icon} alt="" />
          <div className={getTotalCartAmount() > 0 ? "dot" : ""}></div>
        </Link>
        <Link
          to="/account"
          className="navbar-profile"
        >
          <img src={assets.profile_icon} alt="" />
        </Link>
        <button onClick={handleShowLogin}>Đăng nhập</button>
        <button onClick={handleShowRegister}>Đăng ký</button>
        {/* {
          user && user.isAuthenticated === true
            ? <>
              <Link
                to="/cart"
                className="navbar-search-icon"
              >
                <img src={assets.basket_icon} alt="" />
                <div className={getTotalCartAmount() > 0 ? "dot" : ""}></div>
              </Link>
              <Link
                to="/account"
                className="navbar-profile"
              >
                <img src={assets.profile_icon} alt="" />
              </Link>
            </>
            : <>
              <button onClick={handleShowLogin}>Đăng nhập</button>
              <button onClick={handleShowRegister}>Đăng ký</button>
            </>

        } */}
      </div>
    </div>
  );
};

export default Navbar;
