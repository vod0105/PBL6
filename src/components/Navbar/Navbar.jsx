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
  useEffect(() => {
    dispatch(fetchAllCategories());
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
          to={listCategories.length > 0 ? `/category/${listCategories[0].categoryId}` : "/category"}
          className={({ isActive }) => (isActive ? "active navbar-category" : "navbar-category")}
        >
          Thực đơn
          <ul className="navbar-category-dropdown">
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

        <NavLink
          to="/test-ggmap"
          className={({ isActive }) => (isActive ? 'active' : '')}
        >
          Test GGMAP
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
                    product = {product}
                    setProduct = {setProduct}
                    st = {st}
              />
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
