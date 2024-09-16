import React, { useState } from 'react'
import './Contact.scss'
const Contact = () => {
  const [data, setData] = useState({
    userID: "",
    amount: 1,
    address: "",
  });
  const onChangeHandler = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setData((data) => ({ ...data, [name]: value }));
  };
  const onSubmitHandler = async (event) => {
    event.preventDefault();
  }
  return (
    <div>
      <div>
        <form onSubmit={onSubmitHandler} className="place-order">
          <p className="title">Liên hệ chúng tôi</p>
          <div className="multi-fields">
            <div className="row-edit">
              {/* row-edit: Tránh trùng với class có sẵn */}
              <input
                type="text"
                placeholder="Tên của bạn"
                name="userID"
                value={data.userID}
                onChange={onChangeHandler}
              />
              <input
                type="text"
                placeholder="Số điện thoại"
                name="address"
                value={data.address}
                onChange={onChangeHandler}
              />
            </div>
            <div className="row-edit">
              <input
                type="text"
                placeholder="Email"
                name="address"
                value={data.address}
                onChange={onChangeHandler}
              />
              <input
                type="text"
                placeholder="Tin nhắn"
                name="address"
                value={data.address}
                onChange={onChangeHandler}
              />
            </div>
          </div>
          <button type='submit' className='btn btn_red px-4 rounded-0'>Gửi</button>
        </form>
      </div>
    </div>
  )
}

export default Contact
