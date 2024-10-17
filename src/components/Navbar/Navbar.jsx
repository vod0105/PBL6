import React, { useState, useEffect } from "react";
import "./Navbar.scss";
import { assets } from "../../assets/assets";
import { Link, NavLink } from "react-router-dom";
import { useDispatch, useSelector } from 'react-redux';
import { showLoginModal, showRegisterModal } from "../../redux/actions/modalActions";
import { fetchAllCategories } from "../../redux/actions/categoryActions";
import logoCart from '../../assets/logo/cart.png'
import logoUser from '../../assets/logo/user.png'

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
  const user = useSelector((state) => state.auth.user);
  const account = useSelector((state) => state.auth.account);
  const isAuthenticated = useSelector((state) => state.auth.isAuthenticated);

  const handleShowLogin = () => {
    dispatch(showLoginModal());
  };

  const handleShowRegister = () => {
    dispatch(showRegisterModal());
  };

  // fetch category
  const listCategories = useSelector((state) => {
    return state.category.listCategories;
  })
  // const isLoading = useSelector(state => state.category.isLoading);
  // const isError = useSelector(state => state.category.isError);
  useEffect(() => {
    // console.log("Fetching categories...");
    dispatch(fetchAllCategories());
  }, []);



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
          to={listCategories.length > 0 ? `/category/${listCategories[0].categoryId}` : "/category"}
          className={({ isActive }) => (isActive ? "active navbar-category" : "navbar-category")}
        >
          Thực đơn
          <ul className="navbar-category-dropdown">
            {/* <li>
              <img src={cate_1} alt="" />
              <p>MÓN NGON PHẢI THỬ</p>
            </li>
            */}
            {
              listCategories && listCategories.length > 0
              &&
              listCategories.map((category, index) => {
                return (
                  <Link to={`/category/${category.categoryId}`} key={index}>
                    <li >
                      <img src={'data:image/png;base64,' + category.image} alt="" />
                      <p>{category.categoryName}</p>
                    </li>
                  </Link>

                )
              })
            }
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

        <NavLink
          to="/store"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Cửa hàng
        </NavLink>

      </ul>
      <div className="navbar-right">
        {
          isAuthenticated === true
            ? <>
              <Link
                to="/cart"
                className="navbar-cart-icon"
              >
                <img src={logoCart} alt="" />
                <div className='dot'></div>
              </Link>
              <Link
                to="/account"
                className="navbar-profile"
              >
                <img src={logoUser} alt="" />
              </Link>
            </>
            : <>
              <button onClick={handleShowLogin}>Đăng nhập</button>
              <button onClick={handleShowRegister}>Đăng ký</button>
            </>

        }
      </div>
    </div>
  );
};

export default Navbar;
