import React, { useContext, useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import {
  BiHome,
  BiMessage,
  BiLogoProductHunt,
  BiBorderAll,
  BiCart,
  BiCategory
} from "react-icons/bi";
import "../styles/Sidebar.css";
import { StoreContext } from "../context/StoreContext";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBars, faChevronDown } from "@fortawesome/free-solid-svg-icons";

const Sidebar = () => {
  const { setIsAuthenticated, setUserData, userData } =
    useContext(StoreContext);
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("access_token");
    localStorage.removeItem("role");
    setIsAuthenticated(false);
    navigate("/");
  };

  const [active1, setActive] = useState(false);
  const [openSubMenus, setOpenSubMenus] = useState({});

  const handleClick = () => {
    setActive(!active1);
  };

  const toggleSubMenu = (menu) => {
    setOpenSubMenus((prev) => ({
      ...prev,
      [menu]: !prev[menu],
    }));
  };

  // kiem tra quyen

  const userRole = localStorage.getItem("role");
  console.log("userrole", userRole);
  return (
    <div className={active1 ? "side-bar collaps" : "side-bar"}>
      <div className="menu">
        <div className="logo">
          <Link to="/">
            <img
              src="https://www.shareicon.net/data/2016/09/01/822711_user_512x512.png"
              alt="Logo"
            />
          </Link>
          <p onClick={handleClick}>
            <FontAwesomeIcon icon={faBars} className="bar" />
          </p>
        </div>
        <div className="menu-list">
          {/* <Link className="item" to="/">
            <BiHome className="icon" />
            <p>Info</p>
          </Link>
          <Link className="item" to="/trangchu">
            <BiHome className="icon" />
            <p>Dashboard</p>
          </Link> */}

          <div className="item" onClick={() => toggleSubMenu("user")}>
          <BiHome className="icon" />
            <p>
              Store
              <div
                className={
                  openSubMenus["user"]
                    ? "sub-menu active-sub"
                    : "sub-menu hidden"
                }
              >
                <ul>
                  <li>
                    <Link to="/Liststore">Danh sách Store</Link>
                  </li>
                  <li>
                    <Link to="/AddStore">Thêm Store</Link>
                  </li>
                </ul>
              </div>
            </p>
            <p className="dropdownn">
              <FontAwesomeIcon icon={faChevronDown} />
            </p>
          </div>

          <div className="item" onClick={() => toggleSubMenu("category")}>
            <BiCategory className="icon icon-item" />
            <p>
              Category
              <div
                className={
                  openSubMenus["category"]
                    ? "sub-menu active-sub"
                    : "sub-menu hidden"
                }
              >
                <ul className="sub-item">
                  <li>
                    {" "}
                    <Link to="/admin/Category">List CateGory</Link>
                  </li>
                  <li>
                    <Link to="/admin/addCategory">Thêm CateGory</Link>
                  </li>
                </ul>
              </div>
            </p>
            <p className="dropdownn">
              <FontAwesomeIcon icon={faChevronDown} />
            </p>
          </div>

          <Link className="item" to="/product">
            <BiLogoProductHunt className="icon" />
            <p>Product</p>
          </Link>
          <Link className="item" to="/category">
            <BiBorderAll className="icon" />
            <p>CateGory</p>
          </Link>
          <Link className="item" to="/orders">
            <BiMessage className="icon" />
            <p>Orders</p>
          </Link>
          <Link className="item" to="/cart">
            <BiCart className="icon" />
            <p>Cart</p>
          </Link>
          <button className="logout" onClick={handleLogout}>
            Logout
          </button>
        </div>
      </div>
    </div>
  );
};

export default Sidebar;
