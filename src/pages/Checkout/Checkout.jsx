import React, { useState, useEffect } from "react";
import "./Checkout.scss";
import { useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from 'react-redux';
import { placeOrderBuyNow, placeOrderComboBuyNow, placeOrderAddToCart } from "../../redux/actions/userActions";
import { toast } from "react-toastify";

//MAP
import axios from 'axios';
import { MapContainer, TileLayer, Polyline, Marker, Popup, useMap, useMapEvents } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import polyline from 'polyline'; // Import polyline library

// Component Click chuột trên map
const LocationMarker = ({ setPosition }) => {
    useMapEvents({
        click(e) {
            const { lat, lng } = e.latlng;
            setPosition([lat, lng]); // Cập nhật vị trí với tọa độ đã click
        },
    });
    return null;
};

const Checkout = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const isBuyNow = useSelector((state) => state.user.isBuyNow);
    const isBuyNowCombo = useSelector((state) => state.user.isBuyNowCombo);
    const productDetailBuyNow = useSelector((state) => state.user.productDetailBuyNow);
    const comboDetailBuyNow = useSelector((state) => state.user.comboDetailBuyNow);
    const listProductsInCart = useSelector((state) => state.user.listProductsInCart);
    const listCombosInCart = useSelector((state) => state.user.listCombosInCart);
    const accountInfo = useSelector((state) => {
        return state.auth.account;
    });

    const [fullname, setFullname] = useState(accountInfo.fullName);
    const [phonenumber, setPhonenumber] = useState(accountInfo.phoneNumber);
    const [address, setAddress] = useState("hehehe");
    const [note, setNote] = useState("");
    const [paymentMethod, setPaymentMethod] = useState("Thanh toán khi nhận hàng");

    const getTotalPriceInCart = () => {
        let total = 0;
        for (let i = 0; i < listProductsInCart.length; i++) {
            total += (listProductsInCart[i].product.unitPrice * listProductsInCart[i].product.quantity);
        }
        for (let i = 0; i < listCombosInCart.length; i++) {
            total += (listCombosInCart[i].combo.unitPrice * listCombosInCart[i].combo.quantity);
        }
        return total;
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
                    break;
            }
            if (isBuyNow === true && isBuyNowCombo === false) { // Mua ngay PRODUCT
                dispatch(placeOrderBuyNow(method, productDetailBuyNow, address, addressCoords[1], addressCoords[0], navigate));
            }
            else if (isBuyNow === false && isBuyNowCombo === true) { // Mua ngay COMBO
                dispatch(placeOrderComboBuyNow(method, comboDetailBuyNow, address, addressCoords[1], addressCoords[0], navigate));
            }
            else { // Mua ở giỏ hàng
                const cartIds = [
                    ...(listProductsInCart && listProductsInCart.length > 0 ? listProductsInCart.map(item => item.cartId) : []),
                    ...(listCombosInCart && listCombosInCart.length > 0 ? listCombosInCart.map(item => item.cartId) : [])
                ];

                dispatch(placeOrderAddToCart(method, cartIds, address, addressCoords[1], addressCoords[0], navigate));
            }
        }
    };

    // MAP: OpenRouteService
    const [addressCoords, setAddressCoords] = useState([16.075966, 108.149805]); // Tọa độ hiện tại của mình -> Trên Map
    // const [error, setError] = useState(null);
    // const [clickedCoords, setClickedCoords] = useState(null); // Tọa độ click
    const apiKey = '5b3ce3597851110001cf6248d480712f52d0466d8d71a3927b194e84Y';

    // Lấy tọa độ hiện tại
    const getCurrentCoors = () => {
        if ("geolocation" in navigator) {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;
                    // console.log("Current Latitude:", latitude);
                    // console.log("Current Longitude:", longitude);
                    const latLon = [latitude, longitude];
                    setAddressCoords(latLon);
                },
                (error) => {
                    console.error("Error getting location:", error);
                    alert("Không thể lấy vị trí hiện tại. Vui lòng kiểm tra cài đặt vị trí.");
                },
                {
                    enableHighAccuracy: true,  // Yêu cầu độ chính xác cao
                    timeout: 10000,            // Thời gian tối đa để lấy vị trí (ms)
                    maximumAge: 0              // Luôn lấy vị trí mới nhất
                }
            );

        } else {
            console.error("Geolocation is not supported by this browser.");
            alert("Trình duyệt của bạn không hỗ trợ lấy vị trí.");
        }
    }
    // Hàm xử lý click trên bản đồ 
    const handleMapClick = (event) => {
        const { lat, lng } = event.latlng;
        setAddressCoords([lat, lng]); // Lưu tọa độ đã click
    };
    // Component để phóng to bản đồ
    const ZoomToAddress = () => {
        const map = useMap();
        if (addressCoords) {
            map.setView(addressCoords, 16); // Phóng to đến tọa độ với level 18
        }
        return null;
    };

    // Tọa độ -> Địa chỉ
    const fetchAddressFromCoordinates = async (latitude, longitude) => {
        console.log('lấy tọa độ từ địa chỉ');
        try {
            const response = await axios.get(
                `https://api.openrouteservice.org/geocode/reverse?point.lon=${longitude}&point.lat=${latitude}&size=1`,
                {
                    headers: {
                        Authorization: apiKey,
                    },
                }
            );
            if (response.data && response.data.features.length > 0) {
                const address = response.data.features[0].properties.label; // Địa chỉ đầy đủ
                setAddress(address);
                // alert(address);
            }
        } catch (err) {
            console.error("Error details: ", err);
        }
    };

    // Mới vô -> Hiển thị trên input + map => Vị trí hiện tại
    useEffect(() => {
        getCurrentCoors();
        // fetchAddressFromCoordinates(addressCoords[0], addressCoords[1]);  // (lat, lon)
    }, []);

    // Click chuột -> Tọa độ thay đổi -> Input thay đổi
    useEffect(() => {
        if (addressCoords) {
            // console.log('>>> comboDetailBuyNow: ', comboDetailBuyNow);
            // fetchAddressFromCoordinates(addressCoords[0], addressCoords[1]);  // Gọi hàm với tọa độ mới
        }
    }, [addressCoords]);
    return (
        <div className="checkout-page">
            <div className="container">
                <div className="checkout-container">
                    <div className="billing-details">
                        <h2>THÔNG TIN NHẬN HÀNG</h2>
                        <div className="form-group col-md-12">
                            <label htmlFor="">Họ tên</label>
                        </div>
                        <input
                            // className="input-no-change"
                            className="form-control"
                            type="text"
                            placeholder="Họ tên người nhận"
                            value={fullname}
                            disabled={true}
                            required
                        />
                        <div className="form-group col-md-12">
                            <label htmlFor="">Số điện thoại</label>
                            <input
                                // className="input-no-change"
                                className="form-control"
                                type="text"
                                placeholder="Số điện thoại"
                                value={phonenumber}
                                disabled={true}
                                required
                            />
                        </div>
                        <div className="form-group col-md-12">
                            <label htmlFor="">Vị trí nhận hàng</label>
                            <input
                                className="form-control"
                                type="text"
                                placeholder="Địa chỉ"
                                value={address}
                                onChange={(e) => setAddress(e.target.value)}
                                disabled={true}
                                required
                            />
                        </div>
                        <div className="map-container">
                            <MapContainer
                                center={[16.2554, 107.9006]}
                                zoom={9}
                                style={{ height: '400px', width: '100%' }}
                                onClick={handleMapClick} //
                            >
                                <TileLayer
                                    url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                                    attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                                />
                                {/* {route && (
                                    <Polyline positions={route} color="blue" />
                                )} */}
                                {addressCoords && (
                                    <Marker position={addressCoords}>
                                        <Popup>
                                            Tọa độ của địa chỉ. {addressCoords}
                                        </Popup>
                                    </Marker>
                                )}
                                {/* {clickedCoords && (
                                    <Marker position={clickedCoords}>
                                        <Popup>
                                            Tọa độ đã click: {clickedCoords.join(", ")}
                                        </Popup>
                                    </Marker>
                                )} */}
                                <LocationMarker setPosition={setAddressCoords} /> {/* Cập nhật vị trí đã click */}
                                <ZoomToAddress /> {/* Thêm component phóng to */}
                            </MapContainer>
                        </div>
                        <div className="form-group col-md-12">
                            <label htmlFor="">Ghi chú</label>
                            <textarea
                                name="note"
                                placeholder="Ghi chú (tùy chọn)"
                                value={note}
                                onChange={(e) => setNote(e.target.value)}
                            />
                        </div>
                    </div>

                    <div className="order-summary">
                        <h3>ĐƠN HÀNG CỦA BẠN</h3>
                        <div className="order-item">
                            <span>Sản phẩm</span>
                            <span>Tổng tiền</span>
                        </div>
                        <div className="order-detail-product">
                            {
                                isBuyNow === false && isBuyNowCombo === false ? ( // Mua trong giỏ hàng
                                    <>
                                        {listProductsInCart && listProductsInCart.length > 0 && listProductsInCart.map((item, index) => (
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
                                        ))}
                                        {listCombosInCart && listCombosInCart.length > 0 && listCombosInCart.map((item, index) => (
                                            <div className="order-detail-product-item" key={index}>
                                                <div className="product-item-infor">
                                                    <div className="product-item-image">
                                                        <img src={'data:image/png;base64,' + item.combo.image} alt="" />
                                                    </div>
                                                    <div className="product-item-infor">
                                                        <p className="infor-name">{item.combo.comboName} {item.combo.dataDrink.productName} ({item.combo.size})</p>
                                                        <div className="infor-price-quantity">
                                                            <p className="infor-price">
                                                                {Number(item.combo.unitPrice).toLocaleString('vi-VN')} đ
                                                            </p>
                                                            <p className="px-2">x</p>
                                                            <p className="infor-quantity">{item.combo.quantity}</p>
                                                        </div>
                                                        <p className="infor-store">Cửa hàng: {item.combo.dataStore.storeName}</p>
                                                    </div>
                                                </div>
                                                <div className="product-item-totalprice">
                                                    <span>{Number(item.combo.unitPrice * item.combo.quantity).toLocaleString('vi-VN')} đ</span>
                                                </div>
                                            </div>
                                        ))}
                                    </>
                                ) : (
                                    isBuyNow === true && isBuyNowCombo === false ? ( // Mua ngay trong PRODUCT
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
                                    ) : ( // Mua ngay trong COMBO
                                        <div className="order-detail-product-item">
                                            <div className="product-item-infor">
                                                <div className="product-item-image">
                                                    <img src={'data:image/png;base64,' + comboDetailBuyNow.combo.image} alt="" />
                                                </div>
                                                <div className="product-item-infor">
                                                    <p className="infor-name">{comboDetailBuyNow.combo.comboName} + {comboDetailBuyNow.drink.productName} ({comboDetailBuyNow.size})</p>
                                                    <div className="infor-price-quantity">
                                                        <p className="infor-price">
                                                            {Number(comboDetailBuyNow.unitPrice).toLocaleString('vi-VN')} đ
                                                        </p>
                                                        <p className="px-2">x</p>
                                                        <p className="infor-quantity">{comboDetailBuyNow.quantity}</p>
                                                    </div>
                                                    <p className="infor-store">Cửa hàng: {comboDetailBuyNow.store.storeName}</p>
                                                </div>
                                            </div>
                                            <div className="product-item-totalprice">
                                                <span>{Number(comboDetailBuyNow.unitPrice * comboDetailBuyNow.quantity).toLocaleString('vi-VN')} đ</span>
                                            </div>
                                        </div>
                                    )
                                )
                            }
                        </div>
                        <div className="order-totalprice">
                            <span>Tổng cộng </span>
                            <span>
                                {
                                    (isBuyNow === false && isBuyNowCombo === false)
                                        ? Number(getTotalPriceInCart()).toLocaleString('vi-VN')
                                        : (isBuyNow === false && isBuyNowCombo === true)
                                            ? Number(comboDetailBuyNow.unitPrice * comboDetailBuyNow.quantity).toLocaleString('vi-VN')
                                            : (isBuyNow === true && isBuyNowCombo === false)
                                                ? Number(productDetailBuyNow.product.discountedPrice * productDetailBuyNow.quantity).toLocaleString('vi-VN')
                                                : null
                                } đ
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
                            <span>
                                {
                                    isBuyNow === true && isBuyNowCombo === false
                                        ? Number(productDetailBuyNow.product.discountedPrice * productDetailBuyNow.quantity).toLocaleString('vi-VN')
                                        : isBuyNow === false && isBuyNowCombo === true
                                            ? Number(comboDetailBuyNow.unitPrice * comboDetailBuyNow.quantity).toLocaleString('vi-VN')
                                            : Number(getTotalPriceInCart()).toLocaleString('vi-VN')
                                } đ
                            </span>
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
