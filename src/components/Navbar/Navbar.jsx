import React, { useContext, useState } from "react";
import "./Navbar.css";
import { assets } from "../../assets/assets";
import { Link, useNavigate } from "react-router-dom";
import { StoreContext } from "../../context/StoreContext";

import cate_1 from "../../assets/navbar/cate_1.png";
import cate_2 from "../../assets/navbar/cate_2.png";
import cate_3 from "../../assets/navbar/cate_3.png";
import cate_4 from "../../assets/navbar/cate_4.png";
import cate_5 from "../../assets/navbar/cate_5.png";
import cate_6 from "../../assets/navbar/cate_6.png";
import cate_7 from "../../assets/navbar/cate_7.png";
import cate_8 from "../../assets/navbar/cate_8.png";


const Navbar = ({ setShowLogin }) => {
  const [menu, setMenu] = useState("home");
  const { getTotalCartAmount, setToken, token, setFoodList } =
    useContext(StoreContext);
  const navigate = useNavigate();
  const logOut = () => {
    localStorage.removeItem("token");
    console.log("log out");
    setToken("");

    navigate("/");

    // Đăng xuất thành công
    console.log("Logged out successfully");
  };

  return (
    <div className="navbar">
      <Link to="/" className="logo">
        <img src={assets.logo} alt="" className="logo-image" />
        {/* <p className="logo-name">LILI</p> */}
      </Link>
      <ul className="navbar-menu">
        <Link
          to="/"
          onClick={() => setMenu("home")}
          className={menu === "home" ? "active" : ""}
        >
          Trang chủ
        </Link>
        <Link
          to="/introduce"
          onClick={() => setMenu("introduce")}
          className={menu === "introduce" ? "active" : ""}
        >
          Giới thiệu
        </Link>
        <Link
          to="/category"
          onClick={() => setMenu("category")}
          className={menu === "category" ? "active navbar-category" : "navbar-category"}
        >
          Thực đơn
          <ul className="navbar-category-dropdown">
            <li>
              <img src={cate_1} alt="" />
              <p>MÓN NGON PHẢI THỬ</p>
            </li>

            <li>
              <img src={cate_2} alt="" />
              <p onClick={logOut}>GÀ GIÒN VUI VẺ</p>
            </li>
            <li>
              <img src={cate_3} alt="" />
              <p>MỲ Ý</p>
            </li>

            <li>
              <img src={cate_4} alt="" />
              <p onClick={logOut}>GÀ SỐT CAY</p>
            </li>
            <li>
              <img src={cate_5} alt="" />
              <p>BURGER</p>
            </li>

            <li>
              <img src={cate_6} alt="" />
              <p onClick={logOut}>PHẦN ĂN PHỤ</p>
            </li>
            <li>
              <img src={cate_7} alt="" />
              <p>MÓN TRÁNG MIỆNG</p>
            </li>
            <li>
              <img src={cate_8} alt="" />
              <p onClick={logOut}>THỨC UỐNG</p>
            </li>
          </ul>
        </Link>

        <Link
          to="/promotion"
          onClick={() => setMenu("promotion")}
          className={menu === "promotion" ? "active" : ""}
        >
          Khuyến mãi
        </Link>
        <Link
          to="/contact"
          onClick={() => setMenu("contact")}
          className={menu === "contact" ? "active" : ""}
        >
          Liên hệ
        </Link>
        <Link
          to="/store"
          onClick={() => setMenu("store")}
          className={menu === "store" ? "active" : ""}
        >
          Cửa hàng
        </Link>

        {/* <Link
          to="/account"
          onClick={() => setMenu("account")}
          className={menu === "account" ? "active" : ""}
        >
          Tài khoản
        </Link> */}

      </ul>
      <div className="navbar-right">
        {/* <img src={assets.search_icon} alt="" /> */}
        <Link to="/cart" className="navbar-search-icon">
          <img src={assets.basket_icon} alt="" />
          <div className={getTotalCartAmount() > 0 ? "dot" : ""}></div>
        </Link>
        {
          token ? (
            <button onClick={() => setShowLogin(true)}>Đăng nhập</button>
          ) : (
            // <div className="navbar-profile">
            //   <img src={assets.profile_icon} alt="" />
            //   <ul className="navbar-profile-dropdown">
            //     <li onClick={logOut} >
            //       <img src={assets.logout_icon} alt="" />
            //       <p>Logout</p>
            //     </li>
            //     <hr />
            //     <li>
            //       <img src={assets.bag_icon} alt="" />
            //       <p>Orders</p>
            //     </li>
            //   </ul>
            // </div>
            <Link to="/account" className="navbar-profile">
              <img src={assets.profile_icon} alt="" />
            </Link>
          )
        }
      </div>
    </div>
  );
};

export default Navbar;
// import React, { useContext, useState } from "react";
// import "./Navbar.css";
// import { assets } from "../../assets/assets";
// import { Link } from "react-router-dom";
// import { StoreContext } from "../../context/StoreContext";
// import Dropdown from "react-bootstrap/Dropdown";
// import DropdownButton from "react-bootstrap/DropdownButton";

// const Navbar = ({ setShowLogin }) => {
//   const [menu, setMenu] = useState("home");
//   const { getTotalCartAmount, setToken, token } = useContext(StoreContext);

//   return (
//     <div className="navbar">
//       <Link to="/">
//         <img src={assets.logo} alt="" className="logo" />
//       </Link>
//       <ul className="navbar-menu">
//         <Link
//           to="/"
//           onClick={() => setMenu("home")}
//           className={menu === "home" ? "active" : ""}
//         >
//           home
//         </Link>
//         <a
//           href="#explore-menu"
//           onClick={() => setMenu("menu")}
//           className={menu === "menu" ? "active" : ""}
//         >
//           menu
//         </a>
//         <a
//           href="#app-download"
//           onClick={() => setMenu("mobile-app")}
//           className={menu === "mobile-app" ? "active" : ""}
//         >
//           mobile-app
//         </a>
//         <a
//           href="#food-display"
//           onClick={() => setMenu("food-display")}
//           className={menu === "food-display" ? "active" : ""}
//         >
//           food-display
//         </a>
//         <a
//           href="#footer"
//           onClick={() => setMenu("contact-us")}
//           className={menu === "contact-us" ? "active" : ""}
//         >
//           contact-us
//         </a>
//       </ul>
//       <div className="navbar-right">
//         <img src={assets.search_icon} alt="" />
//         <Link to="/cart" className="navbar-search-icon">
//           <img src={assets.basket_icon} alt="" />
//           <div className={getTotalCartAmount() > 0 ? "dot" : ""}></div>
//         </Link>
//         {!token ? (
//           <button onClick={() => setShowLogin(true)}>sign in</button>
//         ) : (
//           <div className="navbar-profile">
//             <img src={assets.profile_icon} alt="" />
//             <ul className="navbar-profile-dropdown">
//               <li>
//                 <img src={assets.bag_icon} alt="" />
//                 <p>Orders</p>
//               </li>
//               <hr />
//               <li>
//                 <img src={assets.logout_icon} alt="" />
//                 <p>Logout</p>
//               </li>
//             </ul>
//           </div>
//         )}
//         <DropdownButton id="dropdown-basic-button" title="Dropdown">
//           <Dropdown.Item as={Link} to="/cart">
//             cart
//           </Dropdown.Item>
//           <Dropdown.Item as={Link} to="/order">
//             order
//           </Dropdown.Item>
//           <Dropdown.Item as={Link} to="/">
//             Trang chu
//           </Dropdown.Item>
//         </DropdownButton>
//       </div>
//     </div>
//   );
// };

// export default Navbar;
