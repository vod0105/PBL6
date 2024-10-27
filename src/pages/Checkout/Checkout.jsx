import React, { useState } from "react";
import "./Checkout.scss";
import { useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from 'react-redux';
import { placeOrderBuyNow, placeOrderAddToCart } from "../../redux/actions/userActions";
import { toast } from "react-toastify";

const Checkout = () => {
    const [fullname, setFullname] = useState("");
    const [phonenumber, setPhonenumber] = useState("");
    const [address, setAddress] = useState("");
    const [note, setNote] = useState("");
    const [paymentMethod, setPaymentMethod] = useState("Thanh toán khi nhận hàng");

    const dispatch = useDispatch();
    const navigate = useNavigate();
    const isBuyNow = useSelector((state) => state.user.isBuyNow);
    const productDetailBuyNow = useSelector((state) => state.user.productDetailBuyNow);
    const listProductsInCart = useSelector((state) => state.user.listProductsInCart);

    const getTotalPriceInCart = () => {
        return listProductsInCart.reduce((total, item) => total + (item.product.unitPrice * item.product.quantity), 0);
    }

    const handlePlaceOrder = () => {
        if (!fullname || !phonenumber || !address) {
            toast.error('Vui lòng điền đầy đủ thông tin đơn hàng!');
        }
        else {
            let method = 'CASH';
            switch (paymentMethod) {
                case 'Thanh toán khi nhận hàng':
                    method = 'CASH';
                    break;
                case 'Momo':
                    method = 'MOMO';
                    break;
                case 'Zalopay':
                    method = 'ZALOPAY';
                    break;
                default:
                    // Giữ nguyên hoặc xử lý nếu không khớp với trường hợp nào
                    break;
            }
            let longitude = '111';
            let latitude = '222';
            if (isBuyNow) { // Mua ngay
                dispatch(placeOrderBuyNow(method, productDetailBuyNow, address, longitude, latitude, navigate));
                // navigate('/order-complete');
            }
            else { // Mua ở giỏ hàng
                const cartIds = listProductsInCart.map(item => item.cartId);
                dispatch(placeOrderAddToCart(method, cartIds, address, longitude, latitude, navigate));
                // navigate('/order-complete');
            }
        }
    };

    return (
        <div className="checkout-page">
            <div className="container">
                <div className="checkout-container">
                    <div className="billing-details">
                        <h2>THÔNG TIN NHẬN HÀNG</h2>
                        <input
                            type="text"
                            placeholder="Họ tên người nhận"
                            value={fullname}
                            onChange={(e) => setFullname(e.target.value)}
                            required
                        />
                        <input
                            type="text"
                            placeholder="Số điện thoại"
                            value={phonenumber}
                            onChange={(e) => setPhonenumber(e.target.value)}
                            required
                        />
                        <input
                            type="text"
                            placeholder="Địa chỉ nhận hàng"
                            value={address}
                            onChange={(e) => setAddress(e.target.value)}
                            required
                        />
                        <textarea
                            name="note"
                            placeholder="Ghi chú (tùy chọn)"
                            value={note}
                            onChange={(e) => setNote(e.target.value)}
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
                                isBuyNow === false ? (
                                    listProductsInCart && listProductsInCart.length > 0 && listProductsInCart.map((item, index) => (
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
                                                        <p className="px-2">x</p>
                                                        <p className="infor-quantity">{item.product.quantity}</p>
                                                    </div>
                                                    <p className="infor-store">Cửa hàng: {item.product.storeId}</p>
                                                </div>
                                            </div>
                                            <div className="product-item-totalprice">
                                                <span>{Number(item.product.unitPrice * item.product.quantity).toLocaleString('vi-VN')} đ</span>
                                            </div>
                                        </div>
                                    ))
                                ) : (
                                    <div className="order-detail-product-item">
                                        <div className="product-item-infor">
                                            <div className="product-item-image">
                                                <img src={'data:image/png;base64,' + productDetailBuyNow.product.image} alt="" />
                                            </div>
                                            <div className="product-item-infor">
                                                <p className="infor-name">{productDetailBuyNow.product.productName} ({productDetailBuyNow.size})</p>
                                                <div className="infor-price-quantity">
                                                    <p className="infor-price">
                                                        {Number(productDetailBuyNow.product.discountedPrice).toLocaleString('vi-VN')} đ
                                                    </p>
                                                    <p className="px-2">x</p>
                                                    <p className="infor-quantity">{productDetailBuyNow.quantity}</p>
                                                </div>
                                                <p className="infor-store">Cửa hàng: {productDetailBuyNow.store.storeName}</p>
                                            </div>
                                        </div>
                                        <div className="product-item-totalprice">
                                            <span>{Number(productDetailBuyNow.product.discountedPrice * productDetailBuyNow.quantity).toLocaleString('vi-VN')} đ</span>
                                        </div>
                                    </div>
                                )
                            }
                        </div>
                        <div className="order-totalprice">
                            <span>Tổng cộng </span>
                            <span>{isBuyNow
                                ? Number(productDetailBuyNow.product.discountedPrice * productDetailBuyNow.quantity).toLocaleString('vi-VN')
                                : Number(getTotalPriceInCart()).toLocaleString('vi-VN')} đ
                            </span>
                        </div>

                        <div className="shipping-method">
                            {/* note: Phải call api lấy all payment methods -> thêm vô reducer: payment method-> BE chưa làm */}
                            <h3>Phương thức thanh toán</h3>
                            <div>
                                <input
                                    type="radio"
                                    id="cash"
                                    name="paymentMethod"
                                    value="Thanh toán khi nhận hàng"
                                    checked={paymentMethod === "Thanh toán khi nhận hàng"}
                                    onChange={(e) => setPaymentMethod(e.target.value)}
                                />
                                <label htmlFor="cash">Thanh toán khi nhận hàng</label>
                            </div>
                            <div>
                                <input
                                    type="radio"
                                    id="zalopay"
                                    name="paymentMethod"
                                    value="Zalopay"
                                    checked={paymentMethod === "Zalopay"}
                                    onChange={(e) => setPaymentMethod(e.target.value)}
                                />
                                <label htmlFor="Zalopay">Zalopay</label>
                            </div>
                            <div>
                                <input
                                    type="radio"
                                    id="momo"
                                    name="paymentMethod"
                                    value="Momo"
                                    checked={paymentMethod === "Momo"}
                                    onChange={(e) => setPaymentMethod(e.target.value)}
                                />
                                <label htmlFor="momo">Momo</label>
                            </div>
                        </div>

                        <div className="order-item">
                            <span>Tổng đơn hàng</span>
                            <span>{isBuyNow ? Number(productDetailBuyNow.product.discountedPrice * productDetailBuyNow.quantity).toLocaleString('vi-VN') : Number(getTotalPriceInCart()).toLocaleString('vi-VN')} đ</span>
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
