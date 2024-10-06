import React, { useState } from 'react';
import './AccountInfo.scss'; // Nếu có CSS custom, kiểm tra lại phần này

const AccountInfo = () => {
  // State để kiểm soát việc disable/enable các input
  const [isEditing, setIsEditing] = useState(false);

  // Hàm xử lý khi nhấn nút "Cập nhật" hoặc "Lưu thay đổi"
  const handleEditClick = () => {
    setIsEditing(!isEditing); // Đảo ngược trạng thái giữa edit và view
  };

  // Hàm xử lý khi nhấn nút "Hủy"
  const handleCancelClick = () => {
    setIsEditing(false); // Chuyển về trạng thái không chỉnh sửa (disabled input)
  };

  return (
    <div className="account-infor">
      <div className="container">
        <div className="account-infor-icon">
          <i className="icon-i fa-regular fa-user"></i>
          <span className='icon-span'>Thông tin chi tiết</span>
        </div>
        <div className="account-infor-content">
          <div className="row py-3">
            {/* Họ tên */}
            <div className="form-group col-md-6">
              <label htmlFor="fullname">Họ tên</label>
              <input
                type="text"
                className="form-control"
                id="fullname"
                placeholder="Nhập họ tên"
                disabled={!isEditing} // Input chỉ được enable khi isEditing = true
              />
            </div>

            {/* Địa chỉ */}
            <div className="form-group col-md-6">
              <label htmlFor="address">Địa chỉ</label>
              <input
                type="text"
                className="form-control"
                id="address"
                placeholder="Nhập địa chỉ"
                disabled={!isEditing}
              />
            </div>
          </div>

          <div className="row py-3">
            {/* Email */}
            <div className="form-group col-md-6">
              <label htmlFor="exampleInputEmail1">Email</label>
              <input
                type="email"
                className="form-control"
                id="exampleInputEmail1"
                placeholder="Nhập email"
                disabled={!isEditing}
              />
            </div>

            {/* Mật khẩu */}
            <div className="form-group col-md-6">
              <label htmlFor="exampleInputPassword1">Mật khẩu</label>
              <input
                type="password"
                className="form-control"
                id="exampleInputPassword1"
                placeholder="Nhập mật khẩu"
                disabled={!isEditing}
              />
            </div>
          </div>

          <div className="row py-3">
            {/* Số điện thoại */}
            <div className="form-group col-md-6">
              <label htmlFor="phonenumber">Số điện thoại</label>
              <input
                type="text"
                className="form-control"
                id="phonenumber"
                placeholder="Nhập số điện thoại"
                disabled={!isEditing}
              />
            </div>

            {/* Giới tính */}
            <div className="form-group col-md-6">
              <label htmlFor="gender">Giới tính</label>
              <input
                type="text"
                className="form-control"
                id="gender"
                placeholder="Chọn giới tính"
                disabled={!isEditing}
              />
            </div>
          </div>
        </div>
        <div className="account-infor-btn">
          {/* Nút Cập nhật hoặc Lưu thay đổi */}
          <button className="btn btn-dark me-3" onClick={handleEditClick}>
            {isEditing ? 'Lưu thay đổi' : 'Cập nhật'} {/* Đổi nhãn nút theo trạng thái */}
          </button>

          {/* Nút Hủy chỉ hiển thị khi đang chỉnh sửa */}
          {isEditing && (
            <button className="btn btn-danger" onClick={handleCancelClick}>
              Hủy
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default AccountInfo;