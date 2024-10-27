import React, { useState, useEffect } from 'react'
import { Modal, Button } from 'react-bootstrap';
import './ReviewModal.scss'
import logoStar from '../../assets/logo/star.png'
import logoStarNobgColor from '../../assets/logo/star_no_bgcolor.png'
import { useDispatch, useSelector } from 'react-redux';
import { reviewOrder } from '../../redux/actions/userActions';

const ReviewModal = ({ showModal, handleClose, orderDetails }) => {
  const [listProducts, setListProducts] = useState([]);
  const [rating, setRating] = useState(5);  // Số lượng sao được chọn
  const [ratingQuality, setRatingQuality] = useState('Tuyệt vời');
  const [images, setImages] = useState([]);  // Các image đã chọn
  const [commentContent, setCommentContent] = useState('');
  const dispatch = useDispatch();
  useEffect(() => {
    if (orderDetails) {
      setListProducts(orderDetails.orderDetails);
    }
  }, [orderDetails]);

  // Hàm xử lý khi nhấn vào ngôi sao
  const handleStarClick = (index) => {
    setRating(index);  // Cập nhật số lượng sao được chọn
    switch (index) {
      case 1:
        setRatingQuality('Tệ');
        break;
      case 2:
        setRatingQuality('Không hài lòng');
        break;
      case 3:
        setRatingQuality('Bình thường');
        break;
      case 4:
        setRatingQuality('Hài lòng');
        break;
      case 5:
        setRatingQuality('Tuyệt vời');
        break;
      default:
        setRatingQuality('Tuyệt vời');
    }
  };
  // Cập nhật hàm handleImageUpload
  const handleImageUpload = (event, index) => {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        const newImages = [...images];
        newImages[index] = { preview: reader.result, file: file };  // Lưu cả preview và file gốc
        setImages(newImages);
      };
      reader.readAsDataURL(file);  // Đọc file ảnh để lấy preview
    }
  };
  const handleCommentContentChange = (event) => {
    setCommentContent(event.target.value);
  };
  const handleSubmit = () => {
    console.log('>>> order detail đây nè: ', orderDetails);
    const listProductIds = listProducts.map((product) => product.productDetail.productId)
      .join(',');
    const rate = rating;
    const listImageFiles = images.filter((image) => image && image.file) // Lọc ra những phần tử có file
      .map((image) => image.file);  // Trả về chỉ file gốc
    const comment = commentContent;
    dispatch(reviewOrder(listProductIds, rate, listImageFiles, comment));
    handleClose();
  }

  return (
    <Modal
      show={showModal}
      onHide={handleClose}
      dialogClassName="custom-modal-review-order"
      centered
    >
      <Modal.Header closeButton>
        <Modal.Title>Đánh giá</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <div className='review-order-modal'>
          <div className="order-detail-product">
            {
              listProducts && listProducts.length > 0 ? (
                listProducts.map((item, index) => (
                  <div className="order-detail-product-item" key={index}>
                    <div className="product-item-image">
                      <img src={'data:image/png;base64,' + item.productDetail.productImage} alt="" />
                    </div>
                    <div className="product-item-infor">
                      <p className="infor-name">{item.productDetail.productName} ({item.productDetail.size})</p>
                      <div className="infor-price-quantity">
                        <p className="infor-price">
                          {Number(item.productDetail.unitPrice).toLocaleString('vi-VN')} đ
                        </p>
                        <p className="px-2">
                          x
                        </p>
                        <p className="infor-quantity">
                          {item.productDetail.quantity}
                        </p>
                      </div>
                      <p className="infor-store">
                        Cửa hàng: {item.productDetail.storeId}
                      </p>
                    </div>
                  </div>
                ))
              ) : (
                <div>Không có sản phẩm nào</div>
              )
            }
          </div>
          <div className="rating-container">
            <div className="rating-title">
              <span>Chất lượng sản phẩm</span>
            </div>
            <div className="rating-star-container">
              {/* Render các ngôi sao với sự kiện onClick */}
              {[1, 2, 3, 4, 5].map((star, index) => (
                <img
                  key={index}
                  src={star <= rating ? logoStar : logoStarNobgColor}  // Hiển thị sao đầy hoặc sao trống
                  alt=""
                  onClick={() => handleStarClick(star)}  // Cập nhật khi nhấn vào ngôi sao
                  style={{ cursor: 'pointer' }}  // Thay đổi con trỏ khi hover
                />
              ))}
            </div>
            <div className="rating-quality">
              <span>{ratingQuality}</span>  {/* Hiển thị đánh giá chất lượng */}
            </div>
          </div>
          {/* Phần upload hình ảnh */}
          <div className="review-images-container">
            <span>Đăng tải hình ảnh</span>
            <div className="images-container">
              {Array.from({ length: 5 }).map((_, index) => (
                <div key={index} className="image-upload-container">
                  <input
                    type="file"
                    accept="image/*"
                    onChange={(e) => handleImageUpload(e, index)}
                    style={{ display: 'none' }} // Ẩn input file
                    id={`file-input-${index}`} // ID cho input
                  />
                  <label htmlFor={`file-input-${index}`} className="image-upload-label">
                    {images[index] && images[index].preview ? (
                      <img src={images[index].preview} alt={`Preview ${index}`} className="image-preview" />
                    ) : (
                      <div className="image-upload-placeholder">Chọn ảnh</div>
                    )}
                  </label>
                </div>
              ))}
            </div>
          </div>
          <div className="comment-container">
            <label htmlFor="comment">Bình luận</label>
            <textarea name="" id="comment" className='' placeholder='Hãy chia sẻ nhận xét cho sản phẩm này bạn nhé!' value={commentContent} onChange={handleCommentContentChange}></textarea>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="danger" onClick={handleSubmit}>
          Gửi
        </Button>
        <Button variant="secondary" onClick={handleClose}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal>
  )
}

export default ReviewModal;
