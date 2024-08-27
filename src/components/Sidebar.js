// import React from "react";
// import {
//   BiBookAlt,
//   BiHome,
//   BiMessage,
//   BiCategory,
//   BiLogoProductHunt,
//   BiBorderAll,
//   BiCart,
//   BiLogIn,
// } from "react-icons/bi"; // Import only the icons you need
// import "../styles/Sidebar.css";
// const Sidebar = () => {
//   return (
//     <div className="menu">
//       <div className="logo">
//         <h2>ADMIN</h2>
//       </div>
//       <div className="menu-list">
//         <a className="item" href="/a">
//           <BiHome className="icon" />
//           Dashboard
//         </a>
//         <a className="item" href="/a">
//           <BiMessage className="icon" />
//           User
//         </a>
//         <a className="item" href="/a">
//           <BiLogoProductHunt className="icon" />
//           Product
//         </a>
//         <a className="item" href="/a">
//           <BiBorderAll className="icon" />
//           CateGory
//         </a>
//         <a className="item" href="/a">
//           <BiMessage className="icon" />
//           Orders
//         </a>
//         <a className="item" href="/a">
//           <BiCart className="icon" />
//           Cart
//         </a>
//         <a className="item" href="/a">
//           <BiLogIn className="icon" />
//           Logout
//         </a>
//       </div>
//     </div>
//   );
// };

// export default Sidebar;
import React from "react";
import { Link } from "react-router-dom"; // Import Link
import {
  BiBookAlt,
  BiHome,
  BiMessage,
  BiCategory,
  BiLogoProductHunt,
  BiBorderAll,
  BiCart,
  BiLogIn,
} from "react-icons/bi"; // Import only the icons you need
import "../styles/Sidebar.css";

const Sidebar = () => {
  return (
    <div className="menu">
      <div className="logo">
        <h3>ADMIN</h3>
        <Link to="/">
          
          <img src="https://www.shareicon.net/data/2016/09/01/822711_user_512x512.png" />
        </Link>
      </div>
      <div className="menu-list">
        <Link className="item" to="/">
          <BiHome className="icon" />
          Info
        </Link>
        <Link className="item" to="/trangchu">
          <BiHome className="icon" />
          Dashboard
        </Link>
        <Link className="item" to="/home">
          <BiHome className="icon" />
          Home
        </Link>

        <Link className="item" to="/user">
          <BiMessage className="icon" />
          User
        </Link>
        <Link className="item" to="/product">
          <BiLogoProductHunt className="icon" />
          Product
        </Link>
        <Link className="item" to="/category">
          <BiBorderAll className="icon" />
          CateGory
        </Link>
        <Link className="item" to="/orders">
          <BiMessage className="icon" />
          Orders
        </Link>
        <Link className="item" to="/cart">
          <BiCart className="icon" />
          Cart
        </Link>
        <Link className="item" to="/logout">
          <BiLogIn className="icon" />
          Logout
        </Link>
      </div>
    </div>
  );
};

export default Sidebar;
