import React, { useContext, useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import {
  BiHome,
  BiMessage,
  BiLogoProductHunt,
  BiBorderAll,
  BiCart,
  BiCategory,
  BiSolidDashboard,
  BiFoodMenu,
  BiCoin,
  BiUser,
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
    if (!menu) return;
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
          {userRole === "ROLE_ADMIN" && (
            <>
              <Link className="item" to="/admin/dashboard">
                <BiSolidDashboard className="icon" />
                <p>Dashboard</p>
              </Link>
              <div className="item" onClick={() => toggleSubMenu("store")}>
                <Link to="/Liststore" className="linkitem">
                  <BiHome className="icon" />
                </Link>
                <p>
                  Store
                  <div
                    className={
                      openSubMenus["store"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/Liststore">List Store</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/AddStore">Add Store</Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("category")}>
                {/* <BiCategory className="icon icon-item" /> */}
                <Link to="/admin/Category" className="linkitem">
                  <BiCategory className="icon icon-item" />
                </Link>
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
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/Category">List CateGory</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/addCategory">Add CateGory</Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("product")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/admin/product" className="linkitem">
                  <BiLogoProductHunt className="icon icon-item" />
                </Link>
                <p>
                  Product
                  <div
                    className={
                      openSubMenus["product"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/admin/product">List Product</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/addProduct">Add Product</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/addProductToStore">
                          Add Product To Store
                        </Link>
                      </li>
                      {/* <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/test">Test</Link>
                      </li> */}
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("promotion")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/admin/promotion" className="linkitem">
                  <BiCoin className="icon icon-item" />
                </Link>
                <p>
                  Promotion
                  <div
                    className={
                      openSubMenus["promotion"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/admin/promotion">List Promotion</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/addPromotion">Add Promotion</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/addPromotionToStore">
                          Add Promotion To Store
                        </Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("combo")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/admin/promotion" className="linkitem">
                  <BiFoodMenu className="icon icon-item" />
                </Link>
                <p>
                  ComBo
                  <div
                    className={
                      openSubMenus["combo"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/admin/Combo">List ComBo</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/admin/AddCombo">Add ComBo</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/admin/addProductToCombo">
                          Add Product To Combo
                        </Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("Shiper")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/admin/promotion" className="linkitem">
                  <BiUser className="icon icon-item" />
                </Link>
                <p>
                  Shiper
                  <div
                    className={
                      openSubMenus["Shiper"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/admin/shiper">List Shiper</Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
            </>
          )}

          {userRole === "ROLE_OWNER" && (
            <>
              {" "}
              <Link className="item" to="/owner/dashboard">
                <BiSolidDashboard className="icon" />
                <p>Dashboard</p>
              </Link>
              <div className="item" onClick={() => toggleSubMenu("oproduct")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/admin/product" className="linkitem">
                  <BiLogoProductHunt className="icon icon-item" />
                </Link>
                <p>
                  Product
                  <div
                    className={
                      openSubMenus["oproduct"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/owner/product">List Product</Link>
                      </li>

                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/onwer/addProductToStore">
                          Add Product To Store
                        </Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("ocalendar")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/admin/calender" className="linkitem">
                  <BiLogoProductHunt className="icon icon-item" />
                </Link>
                <p>
                  Calendar
                  <div
                    className={
                      openSubMenus["ocalendar"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        <Link to="/owner/calender">Calendar</Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("Oorder")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/admin/product" className="linkitem">
                  <BiLogoProductHunt className="icon icon-item" />
                </Link>
                <p>
                  Order
                  <div
                    className={
                      openSubMenus["Oorder"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/owner/order">Order</Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
              <div className="item" onClick={() => toggleSubMenu("OStaff")}>
                {/* <BiLogoProductHunt className="icon icon-item" /> */}
                <Link to="/owner/AddStaff" className="linkitem">
                  <BiLogoProductHunt className="icon icon-item" />
                </Link>
                <p>
                  Staff
                  <div
                    className={
                      openSubMenus["OStaff"]
                        ? "sub-menu active-sub"
                        : "sub-menu hidden"
                    }
                  >
                    <ul className="sub-item">
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/owner/StaffList">Staff List</Link>
                      </li>
                      <li onClick={(e) => e.stopPropagation()}>
                        {" "}
                        <Link to="/owner/AddStaff">Add Staff</Link>
                      </li>
                    </ul>
                  </div>
                </p>
                <p className="dropdownn">
                  <FontAwesomeIcon icon={faChevronDown} />
                </p>
              </div>
            </>
          )}

          <button className="logout" onClick={handleLogout}>
            Logout
          </button>
        </div>
      </div>
    </div>
  );
};

export default Sidebar;
