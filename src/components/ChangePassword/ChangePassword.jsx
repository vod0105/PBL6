import React from 'react';
import './ChangePassword.scss';

const ChangePassword = () => {
  return (
    <div className="change-password">
      <div className="container">
        <div className="change-password-icon">
          <i class="icon-i fa-solid fa-lock"></i>
          <span className='icon-span'>Đổi mật khẩu</span>
        </div>
        <div className="input-password">
          <div className="row py-3">
            <div className="form-group">
              <label htmlFor="currentPass">Mật khẩu hiện tại</label>
              <input type="password" className="form-control" id="currentPass" placeholder="Nhập mật khẩu hiện tại" />
            </div>
          </div>
          <div className="row py-3">
            <div className="form-group">
              <label htmlFor="newPass">Mật khẩu mới</label>
              <input type="password" className="form-control" id="newPass" placeholder="Nhập mật khẩu mới" />
            </div>
          </div>
          <div className="row py-3">
            <div className="form-group">
              <label htmlFor="enterPass">Nhập lại mật khẩu mới</label>
              <input type="password" className="form-control" id="enterPass" placeholder="Nhập lại mật khẩu mới" />
            </div>
          </div>
        </div>
        <button className="btn btn-dark">
          LƯU THAY ĐỔI
        </button>
      </div>
    </div>
  );
};

export default ChangePassword;
