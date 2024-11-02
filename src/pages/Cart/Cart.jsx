import React, { useState, useEffect } from "react";
import "./Cart.scss";
import { useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from 'react-redux';
import {
  fetchProductsInCart,
  placeOrderUsingAddToCart,
  removeProductInCart,
  increaseOneQuantity,

} from "../../redux/actions/userActions";
import { toast } from "react-toastify";
import { Link } from "react-router-dom";
const Cart = () => {

  const dispatch = useDispatch();
  const navigate = useNavigate();

  const listProducts = useSelector((state) => {
    return state.user.listProductsInCart;
  })
  useEffect(() => {
    dispatch(fetchProductsInCart());
  }, [dispatch]);

  // Tăng/giảm slsp
  const handleIncreaseQuantity = (item) => {
    // note: BE thêm stockQuantity ở mỗi sản phẩm trong giỏ hàng khi trả về data
    // if (item.product.quantity < item.product.stockQuantity) {
    //   increaseOneQuantity(item.cartId);
    // }
    // else {
    //   toast.error('Sản phẩm vượt quá số lượng!')
    // }

    dispatch(increaseOneQuantity(item.cartId));
  };
  const handleDecreaseQuantity = (item) => {
    if (item.product.quantity > 1) {
      // dispatch(updateProductQuantityInCart(item, item.product.quantity - 1));
    }
  };
  // Xóa sản phẩm khỏi giỏ hàng
  const handleRemoveProductInCart = (cartId) => {
    dispatch(removeProductInCart(cartId));
  };
  const getTotalPriceInCart = () => {
    let total = 0;
    for (let i = 0; i < listProducts.length; i++) {
      total += (listProducts[i].product.unitPrice * listProducts[i].product.quantity);
    }
    return total;
  }
  const handlePlaceOrder = () => {
    if (!listProducts || !Array.isArray(listProducts) || listProducts.length === 0) { // -> Xử lý thêm trường hợp listProducts ko phải là Array
      toast.error('Không có sản phẩm trong giỏ hàng!');
    }
    else {
      dispatch(placeOrderUsingAddToCart());
      navigate('/checkout');
    }
  }

  // select -> filter
  const [selectedStore, setSelectedStore] = useState("all");
  const handleStoreChange = (event) => {
    console.log('storeId đang chọn: ', selectedStore);
    setSelectedStore(event.target.value);
    console.log('storeId đang chọn: ', selectedStore);
  };
  const filteredProducts = Array.isArray(listProducts) ? listProducts.filter((item) => {
    console.log('item.product.storeId: ', item.product.storeId);
    return selectedStore === "all" || +item.product.storeId === +selectedStore;
  }) : [];


  return (
    <div className="page-cart">
      <div className="search-filter-container">
        <div className="search-container">
          <div className="row">
            <div className="col-md-12">
              <div className="input-group">
                <input className="form-control border-end-0 border" type="search" id="example-search-input" />
                <span className="input-group-append">
                  <button className="btn btn-outline-secondary bg-white border-start-0 border-bottom-0 border ms-n5" type="button">
                    <i className="fa fa-search"></i>
                  </button>
                </span>
              </div>
            </div>
          </div>
        </div>
        <div className="filter-container">
          <select
            className="form-select"
            value={selectedStore}
            onChange={handleStoreChange}
            aria-label="Default select example"
          >
            <option value="all">Tất cả cửa hàng</option>
            {Array.isArray(listProducts) && listProducts
              .map((item) => item.product.dataStore)
              .filter((value, index, self) => self.findIndex(v => v.storeId === value.storeId) === index)
              .map((store) => (
                <option key={store.storeId} value={store.storeId}>
                  {store.storeName}
                </option>
              ))}
          </select>
        </div>

      </div>
      <div className="cart-items">
        <div className="cart-items-title">
          <p>Sản phẩm</p>
          <p>Tên</p>
          <p>Kích cỡ</p>
          <p>Cửa hàng</p>
          <p>Giá</p>
          <p>Số lượng</p>
          <p>Tổng tiền</p>
          <p>Thao tác</p>
        </div>
        <br />
        <hr />
        {
          filteredProducts && filteredProducts.length > 0 ? (filteredProducts.map((item, index) => {
            return (
              <div key={index}>
                <div className="cart-items-title cart-items-item" key={index}>
                  <Link to={`/product-detail/${item.product.productId}`}>
                    <img src={'data:image/png;base64,' + item.product.image} alt="" />
                  </Link>
                  <p>{item.product.productName}</p>
                  <p>{item.product.size}</p>
                  <p>{item.product.dataStore.storeName}</p>
                  <p>{Number(item.product.unitPrice).toLocaleString('vi-VN')} đ</p>
                  <div className="quantity-controls">
                    <button onClick={() => handleDecreaseQuantity(item)}> <i className="fa-solid fa-minus"></i></button>
                    <p>{item.product.quantity}</p>
                    <button onClick={() => handleIncreaseQuantity(item)}><i className="fa-solid fa-plus"></i></button>
                  </div>
                  <p>{Number(item.product.unitPrice * item.product.quantity).toLocaleString('vi-VN')} đ</p>
                  <p
                    onClick={() => {
                      handleRemoveProductInCart(item.cartId);
                    }}
                  >
                    <i className="fa-solid fa-trash action-delete" ></i>
                  </p>
                </div>
                <hr />
              </div>
            );
          }))
            : (
              <div className="no-product">
                <span>Không có sản phẩm trong giỏ hàng</span>
              </div>
            )
        }
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
          <button
            onClick={handlePlaceOrder}
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
