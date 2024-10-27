import React, { useState, useEffect } from 'react'
import './ProductItemDetail.scss'
import test_product from "../../assets/food-yummy/product3.jpg";
import { assets } from '../../assets/assets'
import store1 from "../../assets/image_gg/introduce_1.png";
import store2 from "../../assets/image_gg/introduce_2.png";
import store3 from "../../assets/image_gg/introduce_3.png";
import store4 from "../../assets/image_gg/introduce_4.png";
import store5 from "../../assets/image_gg/introduce_5.png";
import product1 from "../../assets/food-yummy/product1.jpg";
import product2 from "../../assets/food-yummy/product2.jpg";
import product3 from "../../assets/food-yummy/product3.jpg";
import product4 from "../../assets/food-yummy/product4.jpg";

import logoStar from '../../assets/logo/star.png'
import logoStarNobgColor from '../../assets/logo/star_no_bgcolor.png'

import StoreList from '../StoreList/StoreList';
import ProductItemModal from '../ProductItemModal/ProductItemModal';

import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { fetchProductById } from "../../redux/actions/productActions";


const ProductItemDetail = () => {
  const listComments = [
    {
      avatar: product1,
      username: "Nhật Hải",
      rate: 5,
      commentContent: 'ngon tàn bạo, ngon xuất sắc nha cả nhà',
      images: [product2, product3]
    },
    {
      avatar: product2,
      username: "Việt Hoàng",
      rate: 3,
      commentContent: 'Khá là ngon',
      images: [product4]
    },
    {
      avatar: product4,
      username: "Thương Thắng",
      rate: 1,
      commentContent: 'Chưa có món mô dở ri',
      images: [product2, product3, product4]
    },
  ];


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
    setIsAddToCart(true);
    handleShowModalProduct();
  };

  // API
  const { id } = useParams();
  const dispatch = useDispatch();
  const productDetail = useSelector((state) => {
    return state.product.productDetail;
  })
  useEffect(() => {
    dispatch(fetchProductById(id));
  }, [id]);

  if (!productDetail) {
    return <div>Không có thông tin sản phẩm.</div>;
  }
  else return (
    <div className="page-product-detail">
      <div className="container">
        <div className="product-detail-infor">
          <div className="infor-left">
            <div className="infor-left-img-container">
              <img src={'data:image/png;base64,' + productDetail.image} alt="" />
            </div>
          </div>
          <div className="infor-right">
            <div className="infor-right-category">
              <span>{productDetail?.category?.categoryName || 'Danh mục không xác định'}</span>
            </div>

            <div className="infor-right-name">{productDetail.productName}</div>
            <div className="infor-right-review">
              <img src={assets.rating_starts} alt="" />
            </div>
            <hr />
            <div className="infor-right-price-container">
              <span className="infor-right-price-discount">
                {/* {Number(productDetail.price - productDetail.discountedPrice).toLocaleString('vi-VN')} đ */}
                {Number(productDetail.discountedPrice).toLocaleString('vi-VN')} đ
              </span>
              <span className="infor-right-price-origin">
                {Number(productDetail.price).toLocaleString('vi-VN')} đ
              </span>
            </div>
            <div className="infor-right-description">
              <span>Mô tả: {productDetail.description}</span>
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
                onClick={handleAddToCartClick}
              >
                THÊM VÀO GIỎ HÀNG <i className="fa-solid fa-cart-shopping"></i>
              </button>
            </div>
            <div className="infor-right-store">
              <hr />
              <div className="infor-right-store-title">
                <span>* Danh sách cửa hàng hiện có</span>
              </div>
              <StoreList stores={productDetail.stores} />
            </div>
            <ProductItemModal
              showModalProduct={showModalProduct}
              handleCloseModalProduct={handleCloseModalProduct}
              product={productDetail}
              stores={productDetail.stores}
              isAddToCart={isAddToCart}
            />
          </div>
        </div>
        <div className="product-detail-comment">
          <h2>Bài viết đánh giá</h2>
          {listComments && listComments.length > 0 ? (
            listComments.map((comment, index) => {
              return (
                <div className="comment-container" key={index}>
                  <div className="avatar-username-star-container">
                    <div className="avatar">
                      <img src={comment.avatar} alt="" />
                    </div>
                    <div className="username-star">
                      <span className="username-user">{comment.username}</span>
                      <div className="star-container">
                        {[...Array(comment.rate)].map((_, i) => (
                          <img key={i} src={logoStar} alt="" />
                        ))}
                        {[...Array(5 - comment.rate)].map((_, i) => (
                          <img key={i + comment.rate} src={logoStarNobgColor} alt="" />
                        ))}
                      </div>
                    </div>
                  </div>
                  <div className="comment-content">
                    <p>{comment.commentContent}</p>
                  </div>
                  <div className="review-images-container">
                    {comment.images.map((image, imgIndex) => (
                      <img key={imgIndex} src={image} alt={`Review image ${imgIndex}`} className="review-image" />
                    ))}
                  </div>
                  <p className="comment-date">11/05/2024 11:11</p>
                </div>
              );
            })
          ) : (
            <div>Không có bình luận</div>
          )}
        </div>
      </div>
    </div>
  )
}

export default ProductItemDetail
