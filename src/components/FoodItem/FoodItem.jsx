import React, { useContext, useState } from 'react'
import './FoodItem.scss'
import { Link } from "react-router-dom";

import store1 from "../../assets/image_gg/introduce_1.png";
import store2 from "../../assets/image_gg/introduce_2.png";
import store3 from "../../assets/image_gg/introduce_3.png";
import store4 from "../../assets/image_gg/introduce_4.png";
import store5 from "../../assets/image_gg/introduce_5.png";
import ProductItemModal from '../ProductItemModal/ProductItemModal';

const FoodItem = ({ product }) => {
  // Modal
  const [showModalProduct, setShowModalProduct] = useState(false);
  const [isAddToCart, setIsAddToCart] = useState(false);
  const handleShowModalProduct = () => {
    setShowModalProduct(true); // Hiển thị modal
  };
  const handleCloseModalProduct = () => {
    setShowModalProduct(false); // Đóng modal
    setTimeout(() => {
      setIsAddToCart(false);
    }, 200);
  };
  const handleAddToCartClick = () => {
    setIsAddToCart(true); // Kích hoạt chế độ "Thêm vào giỏ hàng"
    handleShowModalProduct(); // Hiển thị modal
  };
  // List stores
  const stores = [
    {
      image: store1,
      name: 'Cửa hàng 1',
      address: 'Địa chỉ cửa hàng 1',
    },
    {
      image: store2,
      name: 'Cửa hàng 2',
      address: 'Địa chỉ cửa hàng 2',
    },
    {
      image: store3,
      name: 'Cửa hàng 3',
      address: 'Địa chỉ cửa hàng 3',
    },
    {
      image: store4,
      name: 'Cửa hàng 4',
      address: 'Địa chỉ cửa hàng 4',
    },
    {
      image: store5,
      name: 'Cửa hàng 5',
      address: 'Địa chỉ cửa hàng 5',
    },
  ];
  return (
    <div className='food-item'>
      <div className="food-item-img-container">
        <Link to={`/test-product-detail/${product.productId}`}>
          <img src={'data:image/png;base64,' + product.image} alt="" className="food-item-image" />
        </Link>
        <div className='food-item-addtocart' onClick={handleAddToCartClick}>
          <i class="fa-solid fa-cart-plus"></i>
        </div>
      </div>
      <div className="food-item-info">
        <div className="food-item-name-rating">
          <p>{product.productName}</p>
        </div>
        {/* <p className="food-item-desc">{description}</p> */}
        {/* <p className="food-item-price">${price}</p> */}
        <div className="food-item-price-container">
          <span className="price-discount">
            {Number(product.price).toLocaleString('vi-VN')} đ
          </span>
          <span className="price-origin">
            {Number(product.discountedPrice).toLocaleString('vi-VN')} đ
          </span>
        </div>
        <button onClick={handleShowModalProduct}>MUA NGAY</button>
        <ProductItemModal
          showModalProduct={showModalProduct}
          handleCloseModalProduct={handleCloseModalProduct}
          product={product}
          stores={stores}
          isAddToCart={isAddToCart}
        />
      </div>
    </div>
  )
}

export default FoodItem
