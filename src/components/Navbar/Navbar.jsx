import React, { useState, useEffect } from "react";
import "./Navbar.scss";
import { assets } from "../../assets/assets";
import { Link, NavLink, useLocation } from "react-router-dom";
import { useDispatch, useSelector } from 'react-redux';
import { showLoginModal, showRegisterModal } from "../../redux/actions/modalActions";
// import { fetchAllCategories } from "../../redux/actions/categoryActions";
import logoCart from '../../assets/logo/cart.png'
import logoUser from '../../assets/logo/user.png'

import cate_1 from "../../assets/navbar/cate_1.png";
import ChatButton from "../Chatbox/ChatButton";


const Navbar = () => {
  // redux modal
  const dispatch = useDispatch();
  const user = useSelector((state) => state.auth.user);
  const account = useSelector((state) => state.auth.account);
  const isAuthenticated = useSelector((state) => state.auth.isAuthenticated);
  const listProductsInCart = useSelector((state) => state.user.listProductsInCart); // lấy listProducts in cart -> hiển thị chấm đỏ

  const [product, setProduct] = useState(null);
  const [st, setST] = useState(null);

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
  // useEffect(() => {
  //   dispatch(fetchAllCategories());
  // }, []);

  // Mỗi li ở ul thực đơn được nhấn -> active cho THỰC ĐƠN -> Dùng path trên URL 
  const location = useLocation(); // useLocation -> Tự động re-render cho component nào sử dụng Hook này
  // const isMenuActive = listCategories.some( // true/false
  //   (category) => location.pathname === `/category/${category.categoryId}` // condition
  // );
  const isMenuActive = listCategories.some(
    (category) => location.pathname === `/category/${category.categoryId}` || location.pathname === `/combo`
  );


  // ??? -> sticky chưa hiểu: JS + CSS
  useEffect(() => {
    const handleScroll = () => {
      const navbar = document.querySelector('.navbar');
      if (window.scrollY > 60) {
        navbar.classList.add('sticky');
      } else {
        navbar.classList.remove('sticky');
      }
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  return (
    <div className="navbar">
      <NavLink
        to="/" className="logo"
        end // 'end' đảm bảo rằng chỉ '/' (Trang Chủ) được kích hoạt
      >
        <img src={assets.logo} alt="" className="logo-image" />
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
          // to={listCategories.length > 0 ? `combo` : "/category"}
          to={`combo`}
          className={({ isActive }) => (isActive || isMenuActive ? "active navbar-category" : "navbar-category")}
        >
          Thực đơn
          <ul className="navbar-category-dropdown">
            <li className="navbar-category-item">
              <NavLink
                to={`/combo`}
                className={({ isActive }) => (isActive ? "active-category-item" : "")}
              >
                <img src={cate_1} alt="Ảnh combo" />
                <p>Combo</p>
              </NavLink>
            </li>
            {
              listCategories && listCategories.length > 0
              &&
              listCategories.map((category, index) => {
                return (
                  <li key={index} className="navbar-category-item">
                    <NavLink
                      to={`/category/${category.categoryId}`}
                      key={index}
                      className={({ isActive }) => (isActive ? "active-category-item" : "")}
                    >
                      <img src={'data:image/png;base64,' + category.image} alt="" />
                      <p>{category.categoryName}</p>
                    </NavLink>
                  </li>

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

        {/* <NavLink
          to="/contact"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Liên hệ
        </NavLink> */}

        <NavLink
          to="/store"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Cửa hàng
        </NavLink>

        {/* <NavLink
          to="/test-ggmap"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Test GGMAP
        </NavLink> */}

        {/* <NavLink
          to="/test-loading"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Test LOADING
        </NavLink> */}

        <NavLink
          to="/download"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Tải ngay
        </NavLink>

      </ul >
      <div className="navbar-right">
        {
          isAuthenticated === true
            ? <>
              <Link
                to="/cart"
                className="navbar-cart-icon"
              >
                <img src={logoCart} alt="" />
                {
                  listProductsInCart && listProductsInCart.length > 0 && <div className='dot'></div>
                }

              </Link>
              <Link
                to="/account"
                className="navbar-profile"
              >
                {
                  account && account.avatar ? (
                    <img src={'data:image/png;base64,' + account.avatar} alt="avatar-user" title="Quản lý tài khoản" />
                  )
                    : (
                      <img src={logoUser} alt="avatar-user" />
                    )
                }
              </Link>
              <ChatButton
                product={product}
                setProduct={setProduct}
                st={st}
              />
            </>
            : <>
              <button onClick={handleShowLogin}>Đăng nhập</button>
              <button onClick={handleShowRegister}>Đăng ký</button>
            </>
        }
      </div>
    </div >
  );
};

export default Navbar;
