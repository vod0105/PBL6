import React, { useContext } from "react";
import "./Cart.css";
import { StoreContext } from "../../context/StoreContext";
import { assets } from "../../assets/assets";
import { useNavigate } from "react-router-dom";
const Cart = () => {
  const { cartItems, food_list, removeFromCart, getTotalCartAmount, url } =
    useContext(StoreContext);
  const navigate = useNavigate();

  return (
    <div className="cart">
      <div className="cart-items">
        <div className="cart-items-title">
          <p>Sản phẩm</p>
          <p>Tên</p>
          <p>Giá</p>
          <p>Số lượng</p>
          <p>Tổng tiền</p>
          <p>Thao tác</p>
        </div>
        <br />
        <hr />
        {food_list.map((item, index) => {
          if (cartItems[item._id] > 0) {
            return (
              <div>
                <div className="cart-items-title cart-items-item">
                  <img src={item.image} alt="" />
                  <p>{item.name}</p>
                  <p>${item.price}</p>
                  <p>{cartItems[item._id]}</p>
                  <p>${cartItems[item._id] * item.price}</p>
                  <p
                    onClick={() => {
                      removeFromCart(item._id);
                    }}

                  >
                    <i className="fa-solid fa-trash action-delete" ></i>
                  </p>
                </div>
                <hr />
              </div>
            );
          }
        })}
      </div>
      <div className="cart-bottom">
        <div className="cart-total">
          <h2>Giỏ hàng của bạn</h2>
          <div>
            <div className="cart-total-details">
              <p>Tổng đơn hàng</p>
              <p>{getTotalCartAmount()}</p>
            </div>
            <div className="cart-total-details">
              <p>Phí giao hàng</p>
              <p>{getTotalCartAmount() === 0 ? 0 : 10}</p>
            </div>
            <hr />
            <div className="cart-total-details">
              <p>Tổng cộng</p>
              <b>{getTotalCartAmount() === 0 ? 0 : getTotalCartAmount() + 10}</b>
            </div>
          </div>
          <button
          // onClick={() => {
          //   navigate("/order");
          // }}
          >
            Thanh toán
          </button>
        </div>
        <div className="cart-promocode">
          <div>
            <p>Nhập mã khuyến mãi<i></i></p>
            <div className="cart-promocode-input">
              <input type="text" placeholder="Mã khuyến mãi" />
              <button>Xác nhận</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Cart;
