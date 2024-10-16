import React, { useState, useEffect } from "react";
import './AccountInfo.scss'; // Nếu có CSS custom, kiểm tra lại phần này
import { useDispatch, useSelector } from 'react-redux';
import { updateProfile } from "../../redux/actions/userActions";
import { updateAccountAuth } from "../../redux/actions/authActions";

const AccountInfo = () => {
  // redux
  const dispatch = useDispatch();
  const accountInfo = useSelector((state) => {
    return state.auth.account;
  })
  // State để kiểm soát việc disable/enable các input
  const [isEditing, setIsEditing] = useState(false);
  const handleSaveChangeClick = () => {
    setIsEditing(false); // update
    dispatch(updateProfile(phonenumber, fullname, '', email, address));
    dispatch(updateAccountAuth(phonenumber, fullname, '', email, address));
  };
  const handleCancelClick = () => {
    setIsEditing(false); // update
  };
  const handleEditClick = () => {
    setIsEditing(true); // => disabled
  };

  const [fullname, setFullname] = useState(accountInfo.fullName);
  const [phonenumber, setPhonenumber] = useState(accountInfo.phoneNumber);
  const [address, setAddress] = useState(accountInfo.address);
  const [email, setEmail] = useState(accountInfo.email);


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
                value={fullname}
                onChange={(event) => setFullname(event.target.value)}
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
                value={address}
                onChange={(event) => setAddress(event.target.value)}
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
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                disabled={!isEditing}
              />
            </div>

            <div className="form-group col-md-6">
              <label htmlFor="phonenumber">Số điện thoại</label>
              <input
                type="text"
                className="form-control"
                id="phonenumber"
                value={phonenumber}
                onChange={(event) => setPhonenumber(event.target.value)}
                disabled={!isEditing}
              />
            </div>
          </div>

        </div>
        <div className="account-infor-btn">
          {
            isEditing ? (
              <>
                <button className="btn btn-dark me-3" onClick={handleSaveChangeClick}>
                  Lưu thay đổi
                </button>
                <button className="btn btn-danger" onClick={handleCancelClick}>
                  Hủy
                </button>
              </>
            ) : (
              <button className="btn btn-dark me-3" onClick={handleEditClick}>
                Cập nhật
              </button>
            )
          }

        </div>
      </div>
    </div>
  );
};

export default AccountInfo;