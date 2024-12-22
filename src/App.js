import React, { useContext, useEffect, useState } from "react";
import { Route, Routes, Navigate } from "react-router-dom";
import Sidebar from "./components/Sidebar";
import Content from "./components/Content";
import Home from "./pages/Home";
import Login from "./pages/Login/Login";
import "./App.css";
import Register from "./pages/Register/Register";
import { StoreContext } from "./context/StoreContext";
import ChatButton from "./pages/Chatbox/ChatButton";
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
import Promotion from "./pages/promotion/Promotion";
import AddPromotion from "./pages/promotion/AddPromotion";
import AutoLogout from "./context/AutoLogout";
import UpdateProduct from "./pages/Product/UpdateProduct";
import UpdatePromotion from "./pages/promotion/UpdatePromotion";
import Combo from "./pages/Combo/Combo";
import AddCombo from "./pages/Combo/AddCombo";
import AddProducToComBo from "./pages/Combo/AddProductToCombo";
import CalendarPage from "./components/Calender/CalendarPage";
import OwnerDasboard from "./pages/Dashboard/OwnerDasboard";
import OwnerProduct from "./PagesOwner/Product/OwnerProduct";
import OwnerAddProducToStore from "./PagesOwner/Product/OwnerAddproductToStore";
import AddPromotionToStore from "./pages/promotion/AddPromotionToStore";
import UpdateCombo from "./pages/Combo/UpdateCombo";
import Order from "./PagesOwner/Order/Order";
import AddStaff from "./PagesOwner/Staff/AddStaff";
import UpdateStaff from "./PagesOwner/Staff/UpdateStaff";
import StaffList from "./PagesOwner/Staff/Staff";
import OwnerAddProductToStorev2 from "./PagesOwner/Product/OwnerAddproductToStore";
import OrderDetail from "./PagesOwner/Order/OrderDetails";
import SoundNotification from "./components/Notify/Notify";
import Shiper from "./pages/Shiper/Shiper";
import PaginationExample from "./pages/test1/Test1";

const notificationSound = new Audio("/sound/tingting.mp3");
const App = () => {
  const [showChat, setShowChat] = useState(false);
  const [product, setProduct] = useState(null);
  const [st, setST] = useState(null);

  // const isAuthenticated = !!localStorage.getItem("access_token"); // Kiểm tra nếu có token
  const { isAuthenticated, setIsAuthenticated, url, setUrl } =
    useContext(StoreContext);
  const userRole = localStorage.getItem("role");
  useEffect(() => {
    // Kiểm tra token trong localStorage khi component mount
    const checkLogin = localStorage.getItem("access_token");
    // console.log("Token from localStorage:", checkLogin);

    if (checkLogin == null) {
      setIsAuthenticated(false);
    } else {
      setIsAuthenticated(true);
    }
  }, []);

  return (
    <div className="app">
      <AutoLogout />
      {isAuthenticated && (
        <ChatButton
          showChat={showChat}
          setShowChat={setShowChat}
          product={product}
          setProduct={setProduct}
          st={st}
          url={url}
        />
      )}
      <Routes>
        {userRole === "ROLE_ADMIN" && (
          <>
            <Route
              path="/"
              element={
                isAuthenticated && userRole === "ROLE_ADMIN" ? (
                  <Navigate to="/admin/dashboard" />
                ) : (
                  <Login url={url} />
                )
              }
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
              path="/admin/test"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      {/* <div className="side-bar collapse"><Sidebar /></div> */}
                      <Sidebar />

                      <div className="dashboard-content">
                        <PaginationExample />
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
              path="/admin/UpdateProduct/:id"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <UpdateProduct url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />

            {/* end product */}
            <Route
              path="/admin/promotion"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <Promotion url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/Addpromotion"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <AddPromotion url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/UpdatePromotion/:id"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <UpdatePromotion url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/addPromotionToStore"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <AddPromotionToStore url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            {/* endupdate PRomotion */}
            <Route
              path="/admin/Combo"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <Combo url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/AddCombo"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <AddCombo url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/addProductToCombo"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <AddProducToComBo url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/UpdateCombo/:id"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <UpdateCombo url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/calender"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <CalendarPage url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/admin/shiper"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <Shiper url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
          </>
        )}
        <Route
          path="/"
          element={
            isAuthenticated && userRole === "ROLE_OWNER" ? (
              <Navigate to="/owner/dashboard" />
            ) : (
              <Login url={url} />
            )
          }
        />

        {userRole === "ROLE_OWNER" && (
          <>
            <Route
              path="/owner/dashboard"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />

                      <div className="dashboard-content">
                        <OwnerDasboard />
                      </div>
                    </div>
                  </>
                )
              }
            />

            <Route
              path="/owner/product"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <OwnerProduct url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/onwer/addProductToStore"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <OwnerAddProductToStorev2 url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/owner/calender"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <CalendarPage url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/owner/order"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <Order url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/owner/AddStaff"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <AddStaff url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/owner/UpdateStaff/:id"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <UpdateStaff url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
            <Route
              path="/owner/StaffList"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <StaffList url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />

            <Route
              path="/owner/OrderDetails/:Id"
              element={
                !isAuthenticated ? (
                  <Navigate to="/" />
                ) : (
                  <>
                    <div className="dashboard">
                      <Sidebar />
                      <div className="dashboard-content">
                        <OrderDetail url={url} />
                      </div>
                    </div>
                  </>
                )
              }
            />
          </>
        )}
      </Routes>
    </div>
  );
};

export default App;
