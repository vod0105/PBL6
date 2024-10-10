import React, { useState } from 'react'
import './ProductItemDetail.scss'
import test_product from "../../assets/food-yummy/product1.jpg";
import { assets } from '../../assets/assets'
import store1 from "../../assets/image_gg/introduce_1.png";
import store2 from "../../assets/image_gg/introduce_2.png";
import store3 from "../../assets/image_gg/introduce_3.png";
import store4 from "../../assets/image_gg/introduce_4.png";
import store5 from "../../assets/image_gg/introduce_5.png";


import StoreList from '../StoreList/StoreList';
import ProductItemModal from '../ProductItemModal/ProductItemModal';

const ProductItemDetail = () => {
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

  const [showModalProduct, setShowModalProduct] = useState(false);

  const handleShowModalProduct = () => {
    setShowModalProduct(true); // Hiển thị modal
  };
  const handleCloseModalProduct = () => {
    setShowModalProduct(false); // Đóng modal
  };

  return (
    <div className="page-product-detail">
      <div className="container">
        <div className="product-detail-infor">
          <div className="infor-left">
            <div className="infor-left-img-container">
              <img src={test_product} alt="" />
            </div>
          </div>
          <div className="infor-right">
            <div className="infor-right-category">
              <span>GÀ RÁN</span>
            </div>
            <div className="infor-right-name">Gà sốt cay</div>
            <div className="infor-right-review">
              <img src={assets.rating_starts} alt="" />
            </div>
            <hr />
            <div className="infor-right-price-container">
              <span className="infor-right-price-discount">
                {Number(10000).toLocaleString('vi-VN')} đ
              </span>
              <span className="infor-right-price-origin">
                {Number(90000).toLocaleString('vi-VN')} đ
              </span>
            </div>
            <div className="infor-right-description">
              <span>Mô tả: Ngon ơi là ngon phải thử đi</span>
            </div>
            <hr />
            <div className="infor-right-btn-container">
              <button
                className='btn-buynow'
                onClick={handleShowModalProduct}
              >
                MUA NGAY <i className="fa-solid fa-file-invoice-dollar"></i>
              </button>
              <button
                className='btn-addtocart'
                onClick={handleShowModalProduct}
              >
                THÊM VÀO GIỎ HÀNG <i className="fa-solid fa-cart-shopping"></i>
              </button>
            </div>
            <div className="infor-right-store">
              <hr />
              <div className="infor-right-store-title">
                <span>Danh sách cửa hàng hiện có</span>
              </div>
              <StoreList stores={stores} />
            </div>
          </div>
          <ProductItemModal
            showModalProduct={showModalProduct}
            handleCloseModalProduct={handleCloseModalProduct}
            product={stores}
            stores={stores}
          />
        </div>
        <div className="product-detail-comment">
          ĐÂY LÀ COMMENT
        </div>
      </div>
    </div>
  )
}

export default ProductItemDetail
