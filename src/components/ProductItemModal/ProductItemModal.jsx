import React, { useState, useEffect } from "react";
import { Modal, Button } from 'react-bootstrap';
import './ProductItemModal.scss';
import StoreList from '../StoreList/StoreList';
import { useDispatch, useSelector } from 'react-redux';
import { fetchAllSizes } from "../../redux/actions/sizeActions";
import { toast } from "react-toastify";
import { addToCart } from "../../redux/actions/userActions";

const ProductItemModal = ({ showModalProduct, handleCloseModalProduct, product, stores, isAddToCart }) => {
  const dispatch = useDispatch();

  // Size
  const listSizes = useSelector((state) => state.size.listSizes);
  const [selectedSize, setSelectedSize] = useState(listSizes.length > 0 ? listSizes[0].name : "");
  const [selectedStore, setSelectedStore] = useState(null);

  const handleSizeChange = (size) => {
    setSelectedSize(size); // Cập nhật kích thước được chọn 
  };

  const handleStoreSelect = (store) => {
    setSelectedStore(store); // Cập nhật cửa hàng đã chọn
  };

  // Quantity + Total Price
  const [quantity, setQuantity] = useState(1);
  const handleIncrease = () => {
    setQuantity(prevQuantity => prevQuantity + 1);
  };
  const handleDecrease = () => {
    if (quantity > 1) {
      setQuantity(prevQuantity => prevQuantity - 1);
    }
  };

  // Fetch all sizes 
  useEffect(() => {
    dispatch(fetchAllSizes());
  }, [dispatch]);

  // list sizes thay đổi -> Chọn size đầu tiên
  useEffect(() => {
    if (listSizes.length > 0) {
      setSelectedSize(listSizes[0].name);
    }
  }, [listSizes]);

  // total price
  const finalPrice = (product?.price != null && product?.discountedPrice != null)
    ? (product.price - product.discountedPrice)
    : 0;
  const handleAddToCart = async () => {
    if (!stores) {
      toast.error('Sản phẩm không có ở cửa hàng nào!');
    }
    else {
      if (!selectedStore) { // Không chọn cửa hàng
        toast.error('Vui lòng chọn cửa hàng');
      }
      else {
        if (quantity > product.stockQuantity) {
          toast.error("Số lượng sản phẩm vượt quy định!")
        }
        else { // Giả sử thêm vào thành công (Chưa xủ lý các điều kiện -> BE chưa làm)
          dispatch(addToCart(product.productId, quantity, selectedStore.storeId, selectedSize, 'Pending'));
          handleModalClose();
        }
      }
    }
  }
  const handleBuyNow = () => {
    if (stores.length === 0) {
      toast.error('Sản phẩm không có ở cửa hàng nào!');
    }
    else {
      if (!selectedStore) { // Không chọn cửa hàng
        toast.error('Vui lòng chọn cửa hàng');
      }
      else { // if: Xử lý tiếp  (Báo lỗi các trường hợp)
        // Note Xử lý: Sản phẩm có:
        // 1. Size khác nhau
        // 2. Cửa hàng khác nhau
        // => Hiển thị số lượng sản phẩm ở cửa hàng tại mỗi size khác nhau
        // => 1. Chọn cửa hàng mới hiển thị size  (Size default: first item)
        //    2. Chọn size -> Hiển thị lại số lượng
        //    3. Chuyển cửa hàng -> Chuyển listSizes + Default size + Số lượng

        // else: Mua được
      }
    }
  }

  // Reset tất cả state khi đóng modal
  const handleModalClose = () => {
    setQuantity(1); 
    setSelectedStore(null); // Reset cửa hàng về null -> Ko chọn cửa hàng nào
    setSelectedSize(listSizes.length > 0 ? listSizes[0].name : ""); // Reset kích thước về kích thước đầu tiên
    handleCloseModalProduct(); 
  };
  return (
    <Modal
      show={showModalProduct}
      onHide={handleModalClose}
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
                          <i className="fa-solid fa-plus"></i>
                        </button>
                      </div>
                      <div className="totalprice-container">
                        <span>{(finalPrice * quantity).toLocaleString()} đ</span>
                      </div>
                    </div>
                    <div className="store">
                      <div className="store-title">
                        {selectedStore ? <span>Cửa hàng đã chọn: {selectedStore.storeName}</span> : <span>Chọn cửa hàng</span>}
                      </div>
                      <StoreList stores={stores} onSelectStore={handleStoreSelect} selectedStore={selectedStore} />
                    </div>

                    {/* Note: Chọn cửa hàng rồi mới hiển thị kích cỡ + số lượng còn lại */}
                    {
                      selectedStore ? (
                        <>
                          <div className="size-container">
                            <span className='title'>Chọn kích cỡ</span>
                            <div className="list-size">
                              {listSizes.map((size, index) => ( // Note: Sửa lại listSizes là của sản phẩm ở cửa hàng được chọn => Default size: first item
                                <div
                                  key={index}
                                  className={`size-item ${selectedSize === size.name ? 'selected' : ''}`}
                                  onClick={() => handleSizeChange(size.name)}
                                >
                                  <span>{size.name}</span>
                                </div>
                              ))}
                            </div>
                          </div>
                          <div className="stock-quantity">  {/* Note: Sửa lại số lượng còn lại là size + cửa hàng chọn có số lượng sp trên */}
                            {selectedStore ? <span>Số lượng sản phẩm còn lại: {product.stockQuantity}</span> : <span></span>}
                          </div>
                        </>
                      )
                        : (
                          <div></div>
                        )

                    }
                    <div className="btn-container">
                      {
                        isAddToCart
                          ? <button onClick={handleAddToCart}>THÊM VÀO GIỎ HÀNG <i className="fa-solid fa-cart-shopping"></i></button>
                          : <button onClick={handleBuyNow}>MUA NGAY <i className="fa-solid fa-file-invoice-dollar"></i></button>
                      }
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ) : (
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
  );
};

export default ProductItemModal;
