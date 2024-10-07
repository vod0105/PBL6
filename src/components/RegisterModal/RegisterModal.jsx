import React from 'react';
import { Modal, Button } from 'react-bootstrap';
import './RegisterModal.scss';

const RegisterModal = ({ showModalRegister, handleCloseRegister, handleShowLogin }) => {
  const switchToLogin = () => {
    handleCloseRegister();
    handleShowLogin();
  };
  return (
    <Modal
      show={showModalRegister}
      onHide={handleCloseRegister}
      centered
      dialogClassName="custom-modal-register"
      animation={false}
    >

      <Modal.Header closeButton>
        <Modal.Title className='title-bold'>ĐĂNG KÝ</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <div className="form-register">
          <div className="container">
            <div className="form-register-input">
              <input type="text" placeholder='Họ tên' />
              <input type="text" placeholder='Số điện thoại' />
              <input type="text" placeholder='Email' />
              <input type="text" placeholder='Địa chỉ' />
              <input type="text" placeholder='Mật khẩu' />
              <input type="text" placeholder='Nhập lại mật khẩu' />
            </div>
            <button className='btn btn-danger'>Đăng ký</button>
            <div className="click-register">
              <p>Bạn đã có tài khoản?</p>
              <button onClick={switchToLogin}>Đăng nhập ngay</button>
            </div>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleCloseRegister}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default RegisterModal;
