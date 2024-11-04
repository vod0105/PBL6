import React, { useState, useEffect } from 'react'
import './ComboItemDetail.scss'
import { assets } from '../../assets/assets'
import logoStar from '../../assets/logo/star.png'
import logoStarNobgColor from '../../assets/logo/star_no_bgcolor.png'
import logoUser from '../../assets/logo/user.png'
import StoreList from '../StoreList/StoreList';
import ImagePreviewModal from '../ImagePreviewModal/ImagePreviewModal'
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { fetchComboById, fetchRatingProductById } from "../../redux/actions/productActions";
import { fetchAllStores } from "../../redux/actions/storeActions";
import ComboItemModal from '../ComboItemModal/ComboItemModal'


const ComboItemDetail = () => {
  // Preview image
  const [showImagePreview, setShowImagePreview] = useState(false);
  const [previewImage, setPreviewImage] = useState('');
  const handleImageClick = (image) => {
    setPreviewImage(image);
    setShowImagePreview(true);
  };
  const handleCloseImagePreview = () => {
    setShowImagePreview(false);
    setPreviewImage('');
  };

  // Format Date
  const formatDate = (dateString) => {
    const date = new Date(dateString);
    const daysOfWeek = ['Chủ nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
    const dayOfWeek = daysOfWeek[date.getDay()];
    const day = date.getDate();  // Lấy ngày
    const month = date.getMonth() + 1;  // Lấy tháng (tháng trong JS bắt đầu từ 0)
    const year = date.getFullYear();  // Lấy năm
    const hours = date.getHours().toString().padStart(2, '0');  // Lấy giờ (padStart để đảm bảo đủ 2 chữ số)
    const minutes = date.getMinutes().toString().padStart(2, '0');  // Lấy phút
    return `${day}/${month}/${year} lúc ${hours}:${minutes}`;
  };
  // Modal
  const [showModalCombo, setShowModalCombo] = useState(false);
  const [isAddToCart, setIsAddToCart] = useState(false);
  const handleShowModalCombo = () => {
    setShowModalCombo(true); // Hiển thị modal
  };
  const handleCloseModalCombo = () => {
    setShowModalCombo(false); // Đóng modal
    setTimeout(() => {
      setIsAddToCart(false);
    }, 200);
  };
  const handleAddToCartClick = () => {
    setIsAddToCart(true);
    handleShowModalCombo();
  };

  // API
  const { id } = useParams();
  const dispatch = useDispatch();
  const comboDetail = useSelector((state) => {
    return state.product.comboDetail;
  })

  // Tìm store chứa tất cả product trong combo
  const filterStoresWithAllComboProducts = (combo) => {
    if (!combo || !combo.products || combo.products.length === 0) return [];
    // Tạo một mảng gồm các storeId từ sản phẩm đầu tiên trong combo
    let commonStores = combo.products[0].stores.map(store => store.storeId);

    // Duyệt qua từng product trong combo để tìm các storeId chung
    combo.products.forEach((product) => {
      const productStoreIds = product.stores.map(store => store.storeId);
      commonStores = commonStores.filter(storeId => productStoreIds.includes(storeId));
    });

    // Lọc lại thông tin chi tiết của các stores có mặt trong commonStores
    const filteredStores = combo.products[0].stores.filter(store =>
      commonStores.includes(store.storeId)
    );
    // console.log('list stores: ', filteredStores);
    return filteredStores;
  };


  const stores = useSelector((state) => {
    return state.store.listStores;
  })
  // const ratingProduct = useSelector((state) => {
  //   return state.product.ratingProduct;
  // })
  useEffect(() => {
    dispatch(fetchComboById(id));
    dispatch(fetchAllStores());
    // dispatch(fetchRatingProductById(id));

  }, [id]);

  if (!comboDetail) {
    return <div>Không có thông tin combo.</div>;
  }
  else return (
    <div className="page-product-detail">
      <div className="container">
        <div className="product-detail-infor">
          <div className="infor-left">
            <div className="infor-left-img-container">
              <img src={'data:image/png;base64,' + comboDetail.image} alt="" />
            </div>
          </div>
          <div className="infor-right">
            <div className="infor-right-category">
              <span>COMBO</span>
            </div>

            <div className="infor-right-name">{comboDetail.comboName}</div>
            <div className="infor-right-review">
              <img src={assets.rating_starts} alt="" />
            </div>
            <hr />
            <div className="infor-right-products">
              <span>Danh sách sản phẩm trong combo</span>
              <div className="products-container">
                {
                  comboDetail?.products && comboDetail.products.length > 0 ? (comboDetail.products.map((item, index) => {
                    return (
                      <div className="product-item" key={index}>
                        <div className="product-item-image">
                          <img
                            src={'data:image/png;base64,' + item.image}
                            alt='Ảnh sản phẩm'
                          // onClick={() => handleImageClick('data:image/png;base64,' + item.productDetail.productImage)} // Gọi modal preview
                          />
                        </div>
                        <div className="product-item-infor">
                          <p className="infor-name">{item.productName}</p>
                        </div>
                      </div>
                    )
                  }))
                    : (
                      <div>Không có sản phẩm nào</div>
                    )
                }
              </div>
            </div>
            <hr />
            <div className="infor-right-price-container">
              <span className='title'>Giá bán: </span>
              <span className="infor-right-price-discount">
                {Number(comboDetail.price).toLocaleString('vi-VN')} đ
              </span>
            </div>
            <div className="infor-right-description">
              <span>Mô tả: {comboDetail.description}</span>
            </div>
            <hr />
            <div className="infor-right-btn-container">
              <button
                className='btn-buynow'
                onClick={handleShowModalCombo}
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
              {/* <StoreList stores={productDetail.stores} /> */}
              <StoreList stores={filterStoresWithAllComboProducts(comboDetail)} />
            </div>
            <ComboItemModal
              showModalCombo={showModalCombo}
              handleCloseModalCombo={handleCloseModalCombo}
              combo={comboDetail}
              // stores={comboDetail.stores}
              stores={filterStoresWithAllComboProducts(comboDetail)}
              isAddToCart={isAddToCart}
            />
          </div>
        </div>
        {/* <div className="product-detail-comment">
          <h2>Bài viết đánh giá</h2>
          {ratingProduct && ratingProduct.length > 0 ? (
            ratingProduct.map((comment, index) => { // comment: 1 đánh giá của sp (bởi 1 user)
              return (
                <div className="comment-container" key={index}>
                  <div className="avatar-username-star-container">
                    <div className="avatar">
                      {
                        comment && comment.dataUser && comment.dataUser.avatar ? (
                          <img src={'data:image/png;base64,' + comment.dataUser.avatar} alt="" />
                        ) : (
                          <img src={logoUser} alt="" />
                        )
                      }
                    </div>
                    <div className="username-star">
                      <span className="username-user">
                        {
                          comment && comment.dataUser && comment.dataUser.fullName ? comment.dataUser.fullName : 'Khách hàng'
                        }
                      </span>
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
                    <p>{comment.comment}</p>
                  </div>
                  <div className="review-images-container">
                    {comment.imageRatings && Array.isArray(comment.imageRatings) && comment.imageRatings.map((image, imgIndex) => (
                      <img
                        key={imgIndex}
                        src={'data:image/png;base64,' + image}
                        alt={`Review image ${imgIndex}`}
                        className="review-image"
                        onClick={() => handleImageClick('data:image/png;base64,' + image)} // Gọi modal preview
                      />
                    ))}
                  </div>
                  <p className="comment-date">{formatDate(comment.createdAt)}</p>
                </div>
              );
            })
          ) : (
            <div className='no-comment'>Không có bình luận</div>
          )}
        </div> */}
        {/* Modal preview ảnh */}
        <ImagePreviewModal
          show={showImagePreview}
          image={previewImage}
          onClose={handleCloseImagePreview}
        />
      </div>
    </div>
  )
}

export default ComboItemDetail
