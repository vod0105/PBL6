import React, { useState } from 'react'
import { Modal, Button } from 'react-bootstrap';
import './ProductItemModal.scss'
import test_product from "../../assets/food-yummy/product1.jpg";
import StoreList from '../StoreList/StoreList';
const ProductItemModal = ({ showModalProduct, handleCloseModalProduct, product, stores, isAddToCart }) => {

  // Size
  const sizes = ['S', 'M', 'L', 'XL']; // Danh sách kích cỡ
  const [selectedSize, setSelectedSize] = useState('S'); // Chỉ chọn 1 kích cỡ
  const handleSizeChange = (size) => {
    setSelectedSize(size); // Cập nhật kích thước được chọn khi click vào
  };

  // Quantity + Total Price
  const [quantity, setQuantity] = useState(1); // Giá trị số lượng ban đầu
  const handleIncrease = () => {
    setQuantity(prevQuantity => prevQuantity + 1);
  };
  const handleDecrease = () => {
    if (quantity > 1) { // Đảm bảo số lượng không nhỏ hơn 1
      setQuantity(prevQuantity => prevQuantity - 1);
    }
  };

  // 

  return (
    <Modal
      show={showModalProduct}
      onHide={handleCloseModalProduct}
      dialogClassName="custom-modal-productitem"
      centered
    >
      <Modal.Header closeButton>
        <Modal.Title>Đặt hàng</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        {
          product ? (
            <div className="modal-product-item">
              <div className="container">
                <div className="product-detail-infor">
                  <div className="infor-left">
                    <div className="img-container">
                      <img src={'data:image/png;base64,' + product.image} alt="" />
                    </div>
                  </div>
                  <div className="infor-right">
                    <div className="name">{product.productName}</div>
                    <div className="size-container">
                      <span className='title'>Kích cỡ</span>
                      <div className="list-size">
                        {sizes.map((size, index) => (
                          <div
                            key={index}
                            className={`size-item ${selectedSize === size ? 'selected' : ''}`} // Thêm class 'selected' nếu kích thước được chọn
                            onClick={() => handleSizeChange(size)} // Xử lý sự kiện khi click vào div
                          >
                            <span>{size}</span>
                          </div>
                        ))}
                      </div>


                    </div>
                    <div className="quantity-totalprice-container">
                      <div className="quantity-container">
                        <button className="quantity-btn" onClick={handleDecrease}>
                          <i className="fa-solid fa-minus"></i>
                        </button>
                        <input
                          type="text"
                          value={quantity}
                          readOnly
                          className="quantity-input"
                        />
                        <button className="quantity-btn" onClick={handleIncrease}>
                          <i class="fa-solid fa-plus"></i>
                        </button>
                      </div>
                      <div className="totalprice-container">
                        <span>{((product.price - product.discountedPrice) * quantity).toLocaleString()} đ</span>
                      </div>
                    </div>
                    <div className="store">
                      <div className="store-title">
                        <span>Chọn cửa hàng</span>
                      </div>
                      <StoreList stores={stores} />
                    </div>
                    <div className="btn-container">
                      {
                        isAddToCart ? <button>THÊM VÀO GIỎ HÀNG <i className="fa-solid fa-cart-shopping"></i></button>
                          : <button>MUA NGAY <i className="fa-solid fa-file-invoice-dollar"></i></button>
                      }
                    </div>
                    {/* <button>THÊM VÀO GIỎ HÀNG</button> */}

                  </div>
                </div>

              </div>
            </div>
          )
            : (
              <p>Không có thông tin sản phẩm.</p>
            )
        }
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleCloseModalProduct}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal>
  )
}

export default ProductItemModal
