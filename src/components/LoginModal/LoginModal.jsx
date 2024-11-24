import React, { useState, useEffect } from 'react';
import { Modal, Button } from 'react-bootstrap';
import './LoginModal.scss';
import { toast } from 'react-toastify';
import { useDispatch, useSelector } from 'react-redux';
import { hideLoginModal, showRegisterModal } from '../../redux/actions/modalActions';
import { loginUser, loginGoogle } from '../../redux/actions/authActions';

import { GoogleLogin } from '@react-oauth/google';
import FacebookLogin from 'react-facebook-login';
import fbIcon from '../../assets/logo/facebook.png'
import { useNavigate, useLocation } from 'react-router-dom';

import ForgetPasswordModal from '../ForgetPasswordModal/ForgetPasswordModal';

const LoginModal = () => {
  const dispatch = useDispatch();
  const isAuthenticated = useSelector((state) => {
    return state.auth.isAuthenticated;
  })
  const showModalLogin = useSelector((state) => state.modal.isLoginModalVisible); // Lấy trạng thái từ Redux
  const [phonenumber, setPhonenumber] = useState("");
  const [password, setPassword] = useState("");

  const [showForgetPassword, setShowForgetPassword] = useState(false); // Quản lý hiển thị Modal quên mật khẩu

  const defaultValidInput = {
    isValidPhonenumber: true,
    isValidPassword: true,
  }
  const [objCheckInput, setObjCheckInput] = useState(defaultValidInput);

  //Reset lại dữ liệu input
  const resetInputs = () => {
    setPhonenumber("");
    setPassword("");
    setObjCheckInput(defaultValidInput);
  }

  const switchToRegister = () => {
    resetInputs();
    dispatch(hideLoginModal()); // Đóng LoginModal => Xóa all infor
    dispatch(showRegisterModal());
  };

  const handleLogin = async () => {
    let objCheckValidInput = {
      isValidPhonenumber: true,
      isValidPassword: true,
    }
    if (!phonenumber) {
      objCheckValidInput.isValidPhonenumber = false;
    }
    if (!password) {
      objCheckValidInput.isValidPassword = false;
    }
    setObjCheckInput({ ...objCheckValidInput }); // Hiển thị class 'is-invalid'
    const hasInvalidInput = Object.values(objCheckValidInput).some(value => value === false);
    if (hasInvalidInput) {
      toast.error("Vui lòng điền đầy đủ thông tin");
    }
    else { // Hết lỗi giao diện
      dispatch(loginUser(phonenumber, password));
    }
  }

  // GG
  const handleSuccessGoogle = async (credentialResponse) => {
    // dispatch(loginGoogle(credentialResponse.credential));
    window.location.href = 'http://localhost:8080/oauth2/authorization/google';
  }
  const handleErrorGoogle = () => {
    alert('Lỗi tùm lum');
  }

  // FB
  const handleSuccessFacebook = async () => {
    // dispatch(loginGoogle(credentialResponse.credential));
    window.location.href = 'http://localhost:8080/oauth2/authorization/facebook';
  }
  const handleErrorFacebook = () => {
    alert('Lỗi tùm lum');
  }


  useEffect(() => {
    if (isAuthenticated) { // Login successfully -> Ẩn modal + xóa dl
      resetInputs();
      dispatch(hideLoginModal());
    }
  }, [isAuthenticated, dispatch]);
  return (
    <>
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
                  type="text"
                  placeholder='Số điện thoại'
                  value={phonenumber}
                  onChange={(event) => setPhonenumber(event.target.value)}
                  className={objCheckInput.isValidPhonenumber ? 'form-control' : 'form-control is-invalid'}
                />
                <input
                  type="password"
                  placeholder='Mật khẩu'
                  value={password}
                  className={objCheckInput.isValidPassword ? 'form-control' : 'form-control is-invalid'}
                  onChange={(event) => setPassword(event.target.value)}
                />
                <button
                  className='btn-forgot-password'
                  onClick={() => {
                    resetInputs();
                    dispatch(hideLoginModal());
                    setShowForgetPassword(true);
                  } // Hiện ForgetPasswordModal
                  }
                >
                  Quên mật khẩu
                </button>
              </div>
              <button className='btn btn-danger' onClick={handleLogin}>Đăng nhập</button>
              <div className="google-facebook-container">
                <p>Hoặc đăng nhập với </p>
                <div className="gg-fb-icon">
                  <GoogleLogin
                    onSuccess={handleSuccessGoogle}
                    onError={handleErrorGoogle}
                    type='icon'
                    shape='circle'
                  />
                  {/* <FacebookLogin
                    appId=''
                    autoLoad={true}
                    fields='name,email,picture'
                    textButton={<i className="fa-brands fa-facebook" />}
                    cssClass='custom-facebook-button'
                    onClick={handleSuccessFacebook}
                  /> */}
                </div>
              </div>
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
      {/* Hiển thị Modal Quên mật khẩu */}
      {showForgetPassword && (
        <ForgetPasswordModal
          showModalForgetPassword={showForgetPassword}
          hideForgetPasswordModal={() => setShowForgetPassword(false)} // Ẩn ForgetPasswordModal khi đóng
        />
      )}
    </>
  );
};

export default LoginModal;