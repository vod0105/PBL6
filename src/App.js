// import React from "react";
// import Sidebar from "./components/Sidebar";
// import Content from "./components/Content";
// import Profile from "./components/Profile";
// import { Route, Routes } from "react-router-dom";
// import "./App.css";
// import Home from "./pages/Home";
// const App = () => {
//   return (
// <div className="dashboard">
//   <Sidebar />
//   <div className="dashboard-content">
//     <Routes>
//       <Route path="/" element={<Content />} />
//       <Route path="/home" element={<Home />} />
//     </Routes>
//   </div>
// </div>
//   );
// };

// export default App;
// src/App.js
import React, { useEffect, useState } from "react";
import { Route, Routes, Navigate } from "react-router-dom";
import Sidebar from "./components/Sidebar";
import Content from "./components/Content";
import Home from "./pages/Home";
import Login from "./pages/Login/Login";
import "./App.css";
import Register from "./pages/Register/Register";

const App = () => {
  // const isAuthenticated = !!localStorage.getItem("access_token"); // Kiểm tra nếu có token

  const [isAuthenticated, setIsAuthenticated] = useState(true);
  // const isAuthenticated = !!localStorage.getItem("access_token");
  // console.log(isAuthenticated)
  useEffect(() => {
    setIsAuthenticated(!!localStorage.getItem("access_token"));
  }, []);
  return (
    <div className="app">
      <Routes>
        <Route
          path="/"
          element={!isAuthenticated ? <Login /> : <Navigate to="/trangchu" />}
        />
        <Route
          path="/register"
          element={!isAuthenticated ? <Register /> : <Navigate to="/" />}
        />

        <Route
          path="/trangchu"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <Content />
                  </div>
                </div>
              </>
            )
          }
        />
        <Route
          path="/home"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    aaa
                    <Home />
                  </div>
                </div>
              </>
            )
          }
        />
      </Routes>
    </div>
  );
};

export default App;
