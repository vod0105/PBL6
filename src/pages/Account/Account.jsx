import React from 'react';
import { Routes, Route, NavLink, Navigate } from 'react-router-dom';
import './Account.scss';
import AccountInfo from '../../components/AccountInfo/AccountInfo';
import ChangePassword from '../../components/ChangePassword/ChangePassword';
import Orders from '../../components/Orders/Orders';

const Account = () => {
  const menuOptions = [
    { name: "Thông tin tài khoản", path: "info" }, 
    { name: "Đổi mật khẩu", path: "change-password" }, 
    { name: "Đơn hàng của bạn", path: "orders" }, 
    { name: "Đăng xuất", path: "logout" } 
  ];

  return (
    <div className="account-page">
      {/* Header */}
      <header className="header-account">
        <div className="breadcrumb">
          <span className='pe-3'>Trang chủ</span> &gt; <span className='ps-3'> Quản lý tài khoản</span>
        </div>
        <h1>TÀI KHOẢN CỦA TÔI</h1>
      </header >

      {/* Main content */}
      < div className="main-content" >
        {/* Left side => panel menu */}
        < div className="sidebar" >
          <h6 className='ms-5'>Quản lý tài khoản</h6>
          <ul>
            {menuOptions.map((option) => (
              <li key={option.path}>
                <NavLink
                  to={option.path} // Đường dẫn tương đối
                  className={({ isActive }) => (isActive ? 'active' : '')}
                >
                  {option.name}
                </NavLink>
              </li>
            ))}
          </ul>
        </div >

        {/* Right side => content */}
        < div className="content" >
          <Routes>
            <Route path="info" element={<AccountInfo />} />
            <Route path="change-password" element={<ChangePassword />} />
            <Route path="orders" element={<Orders />} />
            {/* Redirect mặc định đến trang "Thông tin tài khoản" */}
            <Route path="/" element={<Navigate to="info" replace />} />
            {/* <Route path="logout" element={<Logout />} /> */}
          </Routes>
        </div >
      </div >
    </div >
  );
};

export default Account;
