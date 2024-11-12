import React, { useState } from 'react';
import './ChangePassword.scss';
import { useDispatch, useSelector } from 'react-redux';
import { changePasswordUser } from '../../redux/actions/authActions';
import { toast } from 'react-toastify';

const ChangePassword = () => {
  const dispatch = useDispatch();
  const [oldPassword, setOldPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

  const defaultValidInput = {
    isValidOldPassword: true,
    isValidNewPassword: true,
    isValidConfirmPassword: true,
  };
  const [objCheckInput, setObjCheckInput] = useState(defaultValidInput);
  const checkValidInputs = () => {
    let objCheckValidInput = { ...defaultValidInput };
    if (!oldPassword) {
      objCheckValidInput.isValidOldPassword = false;
    }
    if (!newPassword) {
      objCheckValidInput.isValidNewPassword = false;
    }
    if (!confirmPassword) {
      objCheckValidInput.isValidConfirmPassword = false;
    }
    setObjCheckInput({ ...objCheckValidInput });
    const hasInvalidInput = Object.values(objCheckValidInput).some(value => value === false);
    return !hasInvalidInput;
  }
  const handleChangePassword = async () => {
    let isValidInputs = checkValidInputs();
    if (isValidInputs) {
      if (newPassword !== confirmPassword) {
        toast.error("Vui lòng nhập đúng mật khẩu xác nhận!");
      } else {
        dispatch(changePasswordUser(oldPassword, newPassword));
        setObjCheckInput(defaultValidInput);
        setOldPassword('');
        setNewPassword('');
        setConfirmPassword('');
      }
    } else {
      toast.error("Vui lòng điền đầy đủ thông tin!");
    }
  }
  return (
    <div className="change-password">
      <div className="container">
        <div className="change-password-icon">
          <i className="icon-i fa-solid fa-lock"></i>
          <span className='icon-span'>Đổi mật khẩu</span>
        </div>
        <div className="input-password">
          <div className="row py-3">
            <div className="form-group">
              <label htmlFor="currentPass">Mật khẩu hiện tại</label>
              <input
                type="password"
                className={objCheckInput.isValidOldPassword ? 'form-control' : 'form-control is-invalid'} id="currentPass"
                placeholder="Nhập mật khẩu hiện tại"
                value={oldPassword}
                onChange={(event) => setOldPassword(event.target.value)}
              />
            </div>
          </div>
          <div className="row py-3">
            <div className="form-group">
              <label htmlFor="newPass">Mật khẩu mới</label>
              <input
                type="password"
                className={objCheckInput.isValidNewPassword ? 'form-control' : 'form-control is-invalid'} id="newPass"
                placeholder="Nhập mật khẩu mới"
                value={newPassword}
                onChange={(event) => setNewPassword(event.target.value)}
              />
            </div>
          </div>
          <div className="row py-3">
            <div className="form-group">
              <label htmlFor="enterPass">Nhập lại mật khẩu mới</label>
              <input
                type="password"
                className={objCheckInput.isValidConfirmPassword ? 'form-control' : 'form-control is-invalid'} id="enterPass"
                placeholder="Nhập lại mật khẩu mới"
                value={confirmPassword}
                onChange={(event) => setConfirmPassword(event.target.value)}
              />
            </div>
          </div>
        </div>
        <button
          className="btn btn-dark"
          onClick={handleChangePassword}
        >
          LƯU THAY ĐỔI
        </button>
      </div>
    </div>
  );
};

export default ChangePassword;
