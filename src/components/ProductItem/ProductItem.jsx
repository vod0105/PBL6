// Display in Category page
import React, { useState } from 'react'
import './ProductItem.scss'
import { Link } from "react-router-dom";
import ProductItemModal from '../ProductItemModal/ProductItemModal';

import store1 from "../../assets/image_gg/introduce_1.png";
import store2 from "../../assets/image_gg/introduce_2.png";
import store3 from "../../assets/image_gg/introduce_3.png";
import store4 from "../../assets/image_gg/introduce_4.png";
import store5 from "../../assets/image_gg/introduce_5.png";

const ProductItem = ({ product, index }) => {
  // Modal
  const [showModalProduct, setShowModalProduct] = useState(false);
  const [isAddToCart, setIsAddToCart] = useState(false);
  const handleShowModalProduct = () => {
    setShowModalProduct(true); // Hiển thị modal
  };
  // Sửa lỗi đổi state nhanh quá => Chưa kịp đóng Modal mà đổi nút rồi
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
    <div className={(index + 1) % 4 !== 0 ? "category-product-item" : "category-product-item product-no-border-right"} key={index}>
      <div className="product-item-img-container">
        <Link to={`/test-product-detail/${product.productId}`}>
          <img src={'data:image/png;base64,' + product.image} alt="" className="product-item-image" />
        </Link>
        <div className='product-item-addtocart' onClick={handleAddToCartClick}>
          <i class="fa-solid fa-cart-plus"></i>
        </div>
      </div>
      <h4>{product.productName}</h4>
      <div className="product-item-price-container">
        <span className="product-item-price-discount">
          {Number(product.price).toLocaleString('vi-VN')} đ
        </span>
        <span className="product-item-price-origin">
          {(Number(product.price) * 0.9).toLocaleString('vi-VN')} đ
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
  )
}

export default ProductItem
