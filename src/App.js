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
import React, { useContext, useEffect, useState } from "react";
import { Route, Routes, Navigate } from "react-router-dom";
import Sidebar from "./components/Sidebar";
import Content from "./components/Content";
import Home from "./pages/Home";
import Login from "./pages/Login/Login";
import "./App.css";
import Register from "./pages/Register/Register";
import { StoreContext } from "./context/StoreContext";
import Store from "./pages/store/Store";

import Add from "./pages/store/Add";
import Toastify from "./Action/Toastify";
import UpdateStore from "./pages/store/UpdateStore";
import Category from "./pages/CateGory/Category";
import Dashboard from "./pages/Dashboard/Dasboard";
import AddCategory from "./pages/CateGory/Category";
import AddCate from "./pages/CateGory/AddCate";
import UpdateCategory from "./pages/CateGory/UpdateCategory";
import Product from "./pages/Product/Product";
import AddProduct from "./pages/Product/AddProduct";
import AddProducToStore from "./pages/Product/AddproductToStore";
import AddProducToAllStore from "./pages/Product/AddproductToAllStore";

const App = () => {
  // const isAuthenticated = !!localStorage.getItem("access_token"); // Kiểm tra nếu có token
  const { isAuthenticated, setIsAuthenticated, url, setUrl } =
    useContext(StoreContext);

  useEffect(() => {
    // Kiểm tra token trong localStorage khi component mount
    const checkLogin = localStorage.getItem("access_token");
    console.log("Token from localStorage:", checkLogin);

    if (checkLogin == null) {
      setIsAuthenticated(false);
    } else {
      setIsAuthenticated(true);
      console.log("Vao true");
    }
  }, []);

  return (
    <div className="app">
      <Routes>
        <Route
          path="/"
          element={
            !isAuthenticated ? (
              <Login url={url} />
            ) : (
              <Navigate to="/admin/dashboard" />
            )
          }
        />
        <Route
          path="/register"
          element={!isAuthenticated ? <Register /> : <Navigate to="/" />}
        />

        <Route
          path="/admin/dashboard"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  {/* <div className="side-bar collapse"><Sidebar /></div> */}
                  <Sidebar />
                  <div className="dashboard-content">
                    <Dashboard />
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
                    <Home />
                  </div>
                </div>
              </>
            )
          }
        />
        {/* Store  */}
        <Route
          path="/Liststore"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <Store url={url} />
                  </div>
                </div>
              </>
            )
          }
        />

        <Route
          path="/AddStore"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <Add url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
        <Route
          path="/UpdateStore/:id"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <UpdateStore url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
        {/* end store  */}
        <Route
          path="/admin/Category"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <Category url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
        <Route
          path="/admin/addCategory"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <AddCate url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
         <Route
          path="/admin/UpdateCategory/:id"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <UpdateCategory url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
        {/* end Category */}
        <Route
          path="/admin/product"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <Product url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
         <Route
          path="/admin/AddProduct"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <AddProduct url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
         <Route
          path="/admin/AddProductToStore"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <AddProducToStore url={url} />
                  </div>
                </div>
              </>
            )
          }
        />
        <Route
          path="/admin/AddProductToAllStore"
          element={
            !isAuthenticated ? (
              <Navigate to="/" />
            ) : (
              <>
                <div className="dashboard">
                  <Sidebar />
                  <div className="dashboard-content">
                    <AddProducToAllStore url={url} />
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
