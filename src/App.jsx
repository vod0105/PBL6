import React, { useState } from "react";
import Navbar from "./components/Navbar/Navbar";
import { Route, Routes } from "react-router-dom";
import Home from "./pages/Home/Home";
import Cart from "./pages/Cart/Cart";
import PlaceOrder from "./pages/PlaceOrder/PlaceOrder";
import Footer from "./components/Footer/Footer";
import LoginPopup from "./components/LoginPopup/LoginPopup";
import "bootstrap/dist/css/bootstrap.min.css";
import 'bootstrap/dist/css/bootstrap.min.css';

import "./styles/HomeStyle.css";
import Contact from "./pages/Contact/Contact";
import Introduce from "./pages/Introduce/Introduce";
import Category from "./pages/Category/Category";
import Promotion from "./pages/Promotion/Promotion";
import Store from "./pages/store/store";
import Account from "./pages/Account/Account";
const App = () => {
  // const [showLogin, setShowLogin] = useState(false);

  return (
    <>
      {/* {showLogin ? <LoginPopup setShowLogin={setShowLogin} /> : <></>} */}
      <div className="app">
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/introduce" element={<Introduce />} />
          <Route path="/category" element={<Category />} />
          <Route path="/promotion" element={<Promotion />} />
          <Route path="/store" element={<Store />} />
          <Route path="/cart" element={<Cart />} />
          <Route path="/order" element={<PlaceOrder />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/account/*" element={<Account />} /> {/* Thêm /* */}
        </Routes>
      </div>
      <Footer />

    </>
  );
};
export default App;

// import React, { useState } from "react";
// import "./App.css";

// const App = () => {
//   const [selectedOption, setSelectedOption] = useState("Dashboard");

//   const menuOptions = [
//     "Dashboard",
//     "Orders",
//     "Downloads",
//     "Addresses",
//     "Account Details",
//     "Wishlist",
//     "Logout"
//   ];

//   return (
//     <div className="account-page">
//       {/* Header */}
//       <header className="header">
//         <div className="breadcrumb">
//           <span>Home</span> / <span>Shop</span> / <span>My Account</span>
//         </div>
//         <h1>My Account</h1>
//       </header>

//       {/* Main content */}
//       <div className="main-content">
//         {/* Left side menu */}
//         <div className="sidebar">
//           <ul>
//             {menuOptions.map((option) => (
//               <li
//                 key={option}
//                 className={selectedOption === option ? "active" : ""}
//                 onClick={() => setSelectedOption(option)}
//               >
//                 {option}
//               </li>
//             ))}
//           </ul>
//         </div>

//         {/* Right side content */}
//         <div className="content">
//           <h2>{selectedOption}</h2>
//           <p>This is the content for {selectedOption}.</p>
//         </div>
//       </div>
//     </div>
//   );
// };

// export default App;
