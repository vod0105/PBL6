import React, { useState } from 'react';
import { Modal, Button } from 'react-bootstrap';
import './RegisterModal.scss';
import { toast } from 'react-toastify';

const RegisterModal = ({ showModalRegister, handleCloseRegister, handleShowLogin }) => {
  const switchToLogin = () => {
    handleCloseRegister();
    handleShowLogin();
  };
  // JWT
  const [fullname, setFullname] = useState("");
  const [phonenumber, setPhonenumber] = useState("");
  const [address, setAddress] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const defaultValidInput = {
    isValidFullname: true,
    isValidPhonenumber: true,
    isValidAddress: true,
    isValidEmail: true,
    isValidPassword: true,
    isValidConfirmPassword: true,
  }
  const [objCheckInput, setObjCheckInput] = useState(defaultValidInput);

  const checkValidInputs = () => {
    let objCheckValidInput = {
      isValidFullname: true,
      isValidPhonenumber: true,
      isValidAddress: true,
      isValidEmail: true,
      isValidPassword: true,
      isValidConfirmPassword: true,
    }
    if (!fullname) {
      toast.error("Vui lòng nhập họ tên của bạn!");
      objCheckValidInput.isValidFullname = false;
    }
    if (!phonenumber) {
      toast.error("Vui lòng nhập số điện thoại của bạn!");
      objCheckValidInput.isValidPhonenumber = false;
    }
    if (!address) {
      toast.error("Vui lòng nhập địa chỉ của bạn!");
      objCheckValidInput.isValidAddress = false;
    }
    if (!email) {
      toast.error("Vui lòng nhập email của bạn!");
      objCheckValidInput.isValidEmail = false;
    }
    if (!password) {
      toast.error("Vui lòng nhập mật khẩu của bạn!");
      objCheckValidInput.isValidPassword = false;
    }
    if (!confirmPassword) {
      toast.error("Vui lòng nhập mật khẩu xác nhận của bạn!");
      objCheckValidInput.isValidConfirmPassword = false;
    }
    setObjCheckInput({ ...objCheckValidInput });

    // Kiểm tra xem có bất kỳ giá trị nào là false không
    const hasInvalidInput = Object.values(objCheckValidInput).some(value => value === false);
    return hasInvalidInput ? false : true;
  }
  const handleRegister = async () => {
    let isValidInputs = checkValidInputs();
    if (isValidInputs) {
      // let serverData = await registerNewUser(email, phone, username, password); // return Object răng cần await biết
      // if (+serverData.EC === 0) { // Register successfully
      //   toast.success(serverData.EM);
      //   history.push('/login');
      // } else {
      //   toast.error(serverData.EM);
      // }

      // Default: Register Successfully
      toast.success("Đăng ký thành công nha em zai");
      switchToLogin();
    }
  }
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
              {/* <input type="text" placeholder='Họ tên' />
              <input type="text" placeholder='Số điện thoại' />
              <input type="text" placeholder='Địa chỉ' />
              <input type="text" placeholder='Email' />
              <input type="text" placeholder='Mật khẩu' />
              <input type="text" placeholder='Nhập lại mật khẩu' /> */}
              <input
                type="text"
                placeholder='Họ tên'
                value={fullname}
                onChange={(event) => setFullname(event.target.value)}
                className={objCheckInput.isValidFullname ? 'form-control' : 'form-control is-invalid'}
              />
              <input
                type="text"
                placeholder='Số điện thoại'
                value={phonenumber}
                onChange={(event) => setPhonenumber(event.target.value)}
                className={objCheckInput.isValidPhonenumber ? 'form-control' : 'form-control is-invalid'}
              />
              <input
                type="text"
                placeholder='Địa chỉ'
                value={address}
                onChange={(event) => setAddress(event.target.value)}
                className={objCheckInput.isValidAddress ? 'form-control' : 'form-control is-invalid'}
              />
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
              <input
                type="password"
                placeholder='Nhập lại mật khẩu'
                value={confirmPassword}
                className={objCheckInput.isValidConfirmPassword ? 'form-control' : 'form-control is-invalid'}
                onChange={(event) => setConfirmPassword(event.target.value)}
              />
            </div>
            <button className='btn btn-danger' onClick={() => handleRegister()}>Đăng ký</button>
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
