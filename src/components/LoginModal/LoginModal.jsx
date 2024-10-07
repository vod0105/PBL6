import React, { useState } from 'react';
import { Modal, Button } from 'react-bootstrap';
import './LoginModal.scss';
import { toast } from 'react-toastify';

const LoginModal = ({ showModalLogin, handleCloseLogin, handleShowRegister }) => {
  const switchToRegister = () => {
    handleCloseLogin(); // Đóng LoginModal => Need to clear all infor
    handleShowRegister(); // Mở RegisterModal
  };

  // JWT
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const defaultValidInput = {
    isValidEmail: true,
    isValidPassword: true,
  }
  const [objCheckInput, setObjCheckInput] = useState(defaultValidInput)
  const handleLogin = async () => {
    let objCheckValidInput = {
      isValidEmail: true,
      isValidPassword: true,
    }
    if (!email) {
      toast.error("Vui lòng nhập email của bạn!");
      objCheckValidInput.isValidEmail = false;
    }
    if (!password) {
      toast.error("Vui lòng nhập mật khẩu của bạn!");
      objCheckValidInput.isValidPassword = false;
    }
    setObjCheckInput({ ...objCheckValidInput });
    const hasInvalidInput = Object.values(objCheckValidInput).some(value => value === false);
    // Default: Login Successfully
    if (!hasInvalidInput) {
      toast.success("Đăng nhập thành công nha em zai");
      handleCloseLogin();
    }

    // let response = await loginUser(email, password); // return Object răng cần await biết
    // if (response && +response.EC === 0) {
    //   // Login successfully
    //   toast.success(response.EM);
    //   // React - Context
    //   let groupWithRoles = response.DT.groupWithRoles;
    //   let email = response.DT.email;
    //   let username = response.DT.username;
    //   let token = response.DT.access_token;
    //   let data = {
    //     isAuthenticated: true,
    //     token,
    //     account: {
    //       groupWithRoles,
    //       email,
    //       username
    //     }
    //   }
    //   localStorage.setItem("jwt", token);
    //   loginContext(data); // setState in Context
    //   history.push("/users");
    // }
    // if (response && +response.EC !== 0) {
    //   // Login fail // Error server(500)
    //   toast.error(response.EM);
    // }
    // return;
  }

  return (
    <Modal
      show={showModalLogin}
      onHide={handleCloseLogin}
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
              // onKeyPress={(event) => handlePressenter(event)}
              />
            </div>
            <button className='btn btn-danger' onClick={() => handleLogin()}>Đăng nhập</button>
            <div className="click-register">
              <p>Bạn chưa có tài khoản?</p>
              {/* Khi nhấn "Đăng ký ngay", chuyển sang modal đăng ký */}
              <button onClick={switchToRegister}>Đăng ký ngay</button>
            </div>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleCloseLogin}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default LoginModal;
