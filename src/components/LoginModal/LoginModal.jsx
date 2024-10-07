import React, { useState } from 'react';
import { Modal, Button } from 'react-bootstrap';
import './LoginModal.scss';
import { toast } from 'react-toastify';
import { useDispatch, useSelector } from 'react-redux';
import { hideLoginModal, showRegisterModal } from '../../redux/actions/modalActions';
import { loginSuccess, loginError } from '../../redux/actions/authenticationActions';

const LoginModal = () => {
  const dispatch = useDispatch();
  const showModalLogin = useSelector((state) => state.modal.isLoginModalVisible); // Lấy trạng thái từ Redux
  // Kiểm tra giá trị showModalLogin
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const defaultValidInput = {
    isValidEmail: true,
    isValidPassword: true,
  }
  const [objCheckInput, setObjCheckInput] = useState(defaultValidInput);

  // Hàm để reset lại dữ liệu input
  const resetInputs = () => {
    setEmail("");
    setPassword("");
    setObjCheckInput(defaultValidInput);
  }

  const switchToRegister = () => {
    resetInputs();
    dispatch(hideLoginModal()); // Đóng LoginModal => Need to clear all infor
    dispatch(showRegisterModal());
  };

  const handleLogin = async () => {
    let objCheckValidInput = {
      isValidEmail: true,
      isValidPassword: true,
    }
    if (!email) {
      objCheckValidInput.isValidEmail = false;
    }
    if (!password) {
      objCheckValidInput.isValidPassword = false;
    }
    setObjCheckInput({ ...objCheckValidInput });
    const hasInvalidInput = Object.values(objCheckValidInput).some(value => value === false);

    if (hasInvalidInput) {
      toast.error("Chưa điền hết input em ơi!");
    }
    else {
      // Check login
      if (email == 'hoahoe' && password == 'hoala') { // Success
        dispatch(loginSuccess());
        dispatch(hideLoginModal());
        toast.success('Ngon luôn! Đăng nhập OK đó!')
      }
      else { // Fail
        dispatch(loginError());
        toast.error('Sai email hoặc mật khẩu vô Web anh rồi đó em!')
      }
    }
  }

  return (
    <Modal
      show={showModalLogin}
      onHide={() => { // Khi đóng Modal
        dispatch(hideLoginModal());
        resetInputs();
      }}
      centered
      dialogClassName="custom-modal-login"
      animation={false}
    >
      <Modal.Header closeButton>
        <Modal.Title className='title-bold'>ĐĂNG NHẬP</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <div className="form-login">
          <div className="container">
            <div className="form-login-input">
              <input
                type="email"
                placeholder='Email'
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                className={objCheckInput.isValidEmail ? 'form-control' : 'form-control is-invalid'}
              />
              <input
                type="password"
                placeholder='Password'
                value={password}
                className={objCheckInput.isValidPassword ? 'form-control' : 'form-control is-invalid'}
                onChange={(event) => setPassword(event.target.value)}
              />
            </div>
            <button className='btn btn-danger' onClick={handleLogin}>Đăng nhập</button>
            <div className="click-register">
              <p>Bạn chưa có tài khoản?</p>
              <button onClick={switchToRegister}>Đăng ký ngay</button>
            </div>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={() => dispatch(hideLoginModal())}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default LoginModal;