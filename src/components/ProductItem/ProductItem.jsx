// Display in Category page

import React from 'react'
import './ProductItem.scss'
const ProductItem = ({ product, index }) => {
  return (
    <div className={(index + 1) % 4 !== 0 ? "category-product-item" : "category-product-item product-no-border-right"} key={index}>
      <div className="product-item-img-container">
        <img src={product.image} alt="" className="product-item-image" />
        <div className='product-item-addtocart'>
          <i class="fa-solid fa-cart-plus"></i>
        </div>
      </div>
      <h4>{product.name}</h4>
      <div className="product-item-price-container">
        <span className="product-item-price-discount">
          {Number(product.price).toLocaleString('vi-VN')} đ
        </span>
        <span className="product-item-price-origin">
          {(Number(product.price) * 0.9).toLocaleString('vi-VN')} đ
        </span>
      </div>
      <button>MUA NGAY</button>
    </div>
  )
}

export default ProductItem
