import React, { useState, useEffect } from "react";
import "./Cart.scss";
import { assets } from "../../assets/assets";
import { useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from 'react-redux';
import { fetchProductsInCart, placeOrderUsingAddToCart } from "../../redux/actions/userActions";

const Cart = () => {

  const dispatch = useDispatch();
  const navigate = useNavigate();

  const listProducts = useSelector((state) => {
    return state.user.listProductsInCart;
  })
  useEffect(() => {
    dispatch(fetchProductsInCart());
  }, []);

  // Tăng/giảm slsp
  const handleIncreaseQuantity = (item) => {
    if (item.product.quantity < item.product.stockQuantity) {
      // dispatch(updateProductQuantityInCart(item, item.product.quantity + 1));
    }
  };
  const handleDecreaseQuantity = (item) => {
    if (item.product.quantity > 1) {
      // dispatch(updateProductQuantityInCart(item, item.product.quantity - 1));
    }
  };
  const removeProductInCart = (item) => {

  };
  const getTotalPriceInCart = () => {
    let total = 0;
    for (let i = 0; i < listProducts.length; i++) {
      total += listProducts[i].product.totalPrice;
    }
    return total;
  }
  const handlePlaceOrder = () => {
    dispatch(placeOrderUsingAddToCart());
    navigate('/test-place-order');

  }
  return (
    <div className="cart">
      <div className="cart-items">
        <div className="cart-items-title">
          <p>Sản phẩm</p>
          <p>Tên</p>
          <p>Kích cỡ</p>
          <p>Giá</p>
          <p>Số lượng</p>
          <p>Tổng tiền</p>
          <p>Thao tác</p>
        </div>
        <br />
        <hr />
        {listProducts && listProducts.length > 0 && listProducts.map((item, index) => {
          return (
            <div>
              <div className="cart-items-title cart-items-item" key={index}>
                <img src={'data:image/png;base64,' + item.product.image} alt="" />
                <p>{item.product.productName}</p>
                <p>{item.product.size}</p>
                <p>{Number(item.product.unitPrice).toLocaleString('vi-VN')} đ</p>
                <div className="quantity-controls">
                  <button onClick={() => handleDecreaseQuantity(item)}> <i className="fa-solid fa-minus"></i></button>
                  <p>{item.product.quantity}</p>
                  <button onClick={() => handleIncreaseQuantity(item)}><i className="fa-solid fa-plus"></i></button>
                </div>
                <p>{Number(item.product.totalPrice).toLocaleString('vi-VN')} đ</p>
                <p
                  onClick={() => {
                    removeProductInCart(item);
                  }}
                >
                  <i className="fa-solid fa-trash action-delete" ></i>
                </p>
              </div>
              <hr />
            </div>
          );
        })}
      </div>
      <div className="cart-bottom">
        <div className="cart-total">
          <h2>Giỏ hàng của bạn</h2>
          <div>
            <div className="cart-total-details">
              <p>Tổng đơn hàng</p>
              <p>
                {Number(getTotalPriceInCart()).toLocaleString('vi-VN')} đ
              </p>
            </div>
            <div className="cart-total-details">
              <p>Phí giao hàng</p>
              <p>0 đ</p>
            </div>
            <hr />
            <div className="cart-total-details">
              <p>Tổng cộng</p>
              <b>{Number(getTotalPriceInCart()).toLocaleString('vi-VN')} đ</b>
            </div>
          </div>
          <button onClick={handlePlaceOrder}
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
