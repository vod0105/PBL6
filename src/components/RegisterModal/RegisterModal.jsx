import React, { useState } from 'react';
import { Modal, Button } from 'react-bootstrap';
import './RegisterModal.scss';
import { toast } from 'react-toastify';
import { useDispatch, useSelector } from 'react-redux';
import { hideRegisterModal, showLoginModal } from '../../redux/actions/modalActions';

const RegisterModal = () => {
  const dispatch = useDispatch();
  const showModalRegister = useSelector((state) => state.modal.isRegisterModalVisible); // Lấy trạng thái từ Redux

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
  };
  const [objCheckInput, setObjCheckInput] = useState(defaultValidInput);
  // Hàm để reset lại dữ liệu input
  const resetInputs = () => {
    setFullname("");
    setPhonenumber("");
    setAddress("");
    setEmail("");
    setPassword("");
    setConfirmPassword("");
    setObjCheckInput(defaultValidInput);
  }

  const checkValidInputs = () => {
    let objCheckValidInput = { ...defaultValidInput };
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

    const hasInvalidInput = Object.values(objCheckValidInput).some(value => value === false);
    return !hasInvalidInput;
  }

  const handleRegister = async () => {
    let isValidInputs = checkValidInputs();
    if (isValidInputs) {
      // Gọi API để đăng ký người dùng mới
      toast.success("Đăng ký thành công!");
      dispatch(hideRegisterModal()); // Đóng modal sau khi đăng ký thành công
      dispatch(showLoginModal());
    }
  }

  return (
    <Modal
      show={showModalRegister}
      onHide={() => {
        resetInputs();
        dispatch(hideRegisterModal());
      }}
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
            <button className='btn btn-danger' onClick={handleRegister}>Đăng ký</button>
            <div className="click-register">
              <p>Bạn đã có tài khoản?</p>
              <button onClick={() => {
                resetInputs();
                dispatch(hideRegisterModal());
                dispatch(showLoginModal());
              }}>Đăng nhập ngay</button>
            </div>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={() => dispatch(hideRegisterModal())}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default RegisterModal;