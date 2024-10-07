import React from 'react';
import { Modal, Button } from 'react-bootstrap';
import './LoginModal.scss';

const LoginModal = ({ showModalLogin, handleCloseLogin, handleShowRegister }) => {
  const switchToRegister = () => {
    handleCloseLogin(); // Đóng LoginModal
    handleShowRegister(); // Mở RegisterModal
  };

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
              <input type="text" placeholder='Email' />
              <input type="text" placeholder='Mật khẩu' />
            </div>
            <button className='btn btn-danger'>Đăng nhập</button>
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
