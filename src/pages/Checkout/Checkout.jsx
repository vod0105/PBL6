import React, { useState } from "react";
import "./Checkout.scss";
import { useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from 'react-redux';
import { placeOrder } from "../../redux/actions/userActions";


const Checkout = () => {
    const [formData, setFormData] = useState({
        fullname: "",
        phonenumber: "",
        companyName: "",
        address: "",
        note: "",
        paymentMethod: "Thanh toán khi nhận hàng"
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };


    const dispatch = useDispatch();
    const navigate = useNavigate();
    const isBuyNow = useSelector((state) => {
        return state.user.isBuyNow;
    })
    const productDetailBuyNow = useSelector((state) => {
        return state.user.productDetailBuyNow;
    })
    const listProductsInCart = useSelector((state) => {
        return state.user.listProductsInCart;
    })
    const getTotalPriceInCart = () => {
        let total = 0;
        for (let i = 0; i < listProductsInCart.length; i++) {
            total += listProductsInCart[i].product.totalPrice;
        }
        return total;
    }
    const handlePlaceOrder = () => {
        dispatch(placeOrder());
        navigate('/test-order-complete')

    };
    return (
        <div className="checkout-page">
            <div className="container">
                {/* <div className="breadcrumb">
                    <p>Giỏ hàng  &gt; </p>
                    <p>Thông tin đơn hàng </p>
                    <p>&gt; Đặt hàng thành công </p>
                </div> */}
                <div className="checkout-container">
                    <div className="billing-details">
                        <h2>THÔNG TIN NHẬN HÀNG</h2>
                        <input
                            type="text"
                            name="fullname"
                            placeholder="Họ tên người nhận"
                            value={formData.fullname}
                            onChange={handleChange}
                            required
                        />

                        <input
                            type="text"
                            name="phonenumber"
                            placeholder="Số điện thoại"
                            value={formData.phonenumber}
                            onChange={handleChange}
                            required
                        />

                        <input
                            type="text"
                            name="address"
                            placeholder="Địa chỉ nhận hàng"
                            value={formData.address}
                            onChange={handleChange}
                            required
                        />

                        <textarea
                            name="note"
                            placeholder="Ghi chú"
                            value={formData.note}
                            onChange={handleChange}
                        />
                    </div>

                    <div className="order-summary">
                        <h3>ĐƠN HÀNG CỦA BẠN</h3>
                        <div className="order-item">
                            <span>Sản phẩm</span>
                            <span>Tổng tiền</span>
                        </div>
                        <div className="order-detail-product">
                            {
                                isBuyNow === false ? (listProductsInCart && listProductsInCart.length > 0 && listProductsInCart.map((item, index) => {
                                    return (
                                        <div className="order-detail-product-item" key={index}>
                                            <div className="product-item-infor">
                                                <div className="product-item-image">
                                                    <img src={'data:image/png;base64,' + item.product.image} alt="" />
                                                </div>
                                                <div className="product-item-infor">
                                                    <p className="infor-name">{item.product.productName} (L)</p>
                                                    <div className="infor-price-quantity">
                                                        <p className="infor-price">
                                                            {Number(item.product.unitPrice).toLocaleString('vi-VN')} đ
                                                        </p>
                                                        <p className="px-2">
                                                            x
                                                        </p>
                                                        <p className="infor-quantity">
                                                            {item.product.quantity}
                                                        </p>
                                                    </div>
                                                    {/* Note: BE phải trả về storeName của mỗi sản phẩm trong giỏ hàng -> Hiển thị storeName như mua ngay */}
                                                    <p className="infor-store">Cửa hàng: {item.product.storeId}</p>
                                                </div>
                                            </div>
                                            <div className="product-item-totalprice">
                                                <span>{Number(item.product.unitPrice * item.product.quantity).toLocaleString('vi-VN')} đ</span>
                                            </div>
                                        </div>
                                    )
                                }))
                                    : (
                                        <div className="order-detail-product-item">
                                            <div className="product-item-infor">
                                                <div className="product-item-image">
                                                    <img src={'data:image/png;base64,' + productDetailBuyNow.product.image} alt="" />
                                                </div>
                                                <div className="product-item-infor">
                                                    <p className="infor-name">{productDetailBuyNow.product.productName} ({productDetailBuyNow.size})</p>
                                                    <div className="infor-price-quantity">
                                                        <p className="infor-price">
                                                            {Number(productDetailBuyNow.product.price).toLocaleString('vi-VN')} đ
                                                        </p>
                                                        <p className="px-2">
                                                            x
                                                        </p>
                                                        <p className="infor-quantity">
                                                            {productDetailBuyNow.quantity}
                                                        </p>
                                                    </div>
                                                    <p className="infor-store">Cửa hàng: {productDetailBuyNow.store.storeName}</p>
                                                </div>
                                            </div>
                                            <div className="product-item-totalprice">
                                                <span>
                                                    {Number(productDetailBuyNow.product.price * productDetailBuyNow.quantity).toLocaleString('vi-VN')} đ
                                                </span>
                                            </div>
                                        </div>
                                    )
                            }
                        </div>
                        <div className="order-totalprice">
                            <span>Tổng cộng </span>
                            {
                                isBuyNow ? <span>{Number(productDetailBuyNow.product.price * productDetailBuyNow.quantity).toLocaleString('vi-VN')} đ</span>
                                    : <span>{Number(getTotalPriceInCart()).toLocaleString('vi-VN')} đ</span>
                            }

                        </div>

                        <div className="shipping-method">
                            <h3>Phương thức thanh toán</h3>
                            <div>
                                <input
                                    type="radio"
                                    id="cash"
                                    name="paymentMethod"
                                    value="Thanh toán khi nhận hàng"
                                    checked={formData.paymentMethod === "Thanh toán khi nhận hàng"}
                                    onChange={handleChange}
                                />
                                <label htmlFor="cash">Thanh toán khi nhận hàng</label>
                            </div>
                            <div>
                                <input
                                    type="radio"
                                    id="momo"
                                    name="paymentMethod"
                                    value="Momo"
                                    checked={formData.paymentMethod === "Momo"}
                                    onChange={handleChange}
                                />
                                <label htmlFor="momo">Momo</label>
                            </div>
                        </div>

                        <div className="order-item">
                            <span>Tổng đơn hàng</span>
                            {
                                isBuyNow ? <span>{Number(productDetailBuyNow.product.price * productDetailBuyNow.quantity + 20000).toLocaleString('vi-VN')} đ</span>
                                    : <span>{Number(getTotalPriceInCart() + 20000).toLocaleString('vi-VN')} đ</span>
                            }
                        </div>
                        <button className="place-order-btn" onClick={handlePlaceOrder}>
                            ĐẶT HÀNG
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Checkout;
