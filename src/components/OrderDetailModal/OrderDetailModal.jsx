import React from 'react';
import { Modal, Button } from 'react-bootstrap';
import './OrderDetailModal.scss'; 
import imageProduct from '../../assets/3.png'
const OrderDetailModal = ({ showModal, handleClose, orderDetails }) => {
  const listProducts = [
    {
      image: imageProduct,
      name: 'Gà giòn sốt cay',
      price: '130.000 đ',
      quantity: 3
    },
    {
      image: imageProduct,
      name: 'Gà giòn sốt cay',
      price: '130.000 đ',
      quantity: 3
    },
    {
      image: imageProduct,
      name: 'Gà giòn sốt cay',
      price: '130.000 đ',
      quantity: 3
    },
  ];
  return (
    <Modal
      show={showModal}
      onHide={handleClose}
      dialogClassName="custom-modal-orderDetail"
      centered
    >
      <Modal.Header closeButton>
        <Modal.Title>Chi tiết đơn hàng</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        {orderDetails ? (
          <div className="order-detail">
            <div className="order-detail-orderID">
              <p className="orderID-title">
                Mã đơn hàng:
              </p>
              <p className="orderID-content">
                1111
              </p>
            </div>
            <div className="order-detail-infor">
              <div className="order-detail-infor-item">
                <p className="infor-title">Họ tên người nhận</p>
                <p className="infor-content">Biện Văn Nhật</p>
              </div>
              <div className="order-detail-infor-item">
                <p className="infor-title">Số điện thoại</p>
                <p className="infor-content">04357834755</p>
              </div>
              <div className="order-detail-infor-item">
                <p className="infor-title">Email</p>
                <p className="infor-content">jfsdg@gmail.com</p>
              </div>
              <div className="order-detail-infor-item">
                <p className="infor-title">Địa chỉ</p>
                <p className="infor-content">120 Nguyễn Lương Bằng</p>
              </div>
              <div className="order-detail-infor-item">
                <p className="infor-title">Ghi chú</p>
                <p className="infor-content">Đem nhanh nhanh nha anh Shipper</p>
              </div>
            </div>

            <div className="order-detail-status">
              <div className="status-line">
                <div className="status-segment">
                  <div className={`status-bar ${+orderDetails.status >= 1 ? 'active' : ''}`}></div>
                  <i className={`status-icon fa fa-clock ${+orderDetails.status >= 1 ? 'active' : ''}`}></i> {/* Icon cho Đang chờ xác nhận */}
                  <div className={`status-bar ${+orderDetails.status >= 1 ? 'active' : ''}`}></div>
                </div>
                <div className="status-segment">
                  <div className={`status-bar ${+orderDetails.status >= 2 ? 'active' : ''}`}></div>
                  <i className={`status-icon fa-solid fa-hourglass-start ${+orderDetails.status >= 2 ? 'active' : ''}`}></i> {/* Icon cho Đang chuẩn bị */}
                  <div className={`status-bar ${+orderDetails.status >= 2 ? 'active' : ''}`}></div>

                </div>
                <div className="status-segment">
                  <div className={`status-bar ${+orderDetails.status >= 3 ? 'active' : ''}`}></div>
                  <i className={`status-icon fa fa-truck ${+orderDetails.status >= 3 ? 'active' : ''}`}></i> {/* Icon cho Đang giao */}
                  <div className={`status-bar ${+orderDetails.status >= 3 ? 'active' : ''}`}></div>
                </div>
                <div className="status-segment">
                  <div className={`status-bar ${+orderDetails.status >= 4 ? 'active' : ''}`}></div>
                  <i className={`status-icon fa fa-check-circle ${+orderDetails.status >= 4 ? 'active' : ''}`}></i> {/* Icon cho Đã giao */}
                  <div className={`status-bar ${+orderDetails.status >= 4 ? 'active' : ''}`}></div>
                </div>
              </div>
              <div className="status-labels">
                <span>Đang chờ xác nhận</span>
                <span>Đang chuẩn bị</span>
                <span>Đang giao</span>
                <span>Đã giao</span>
              </div>
            </div>

            <div className="order-detail-product">
              {
                listProducts.map((item, index) => {
                  return (
                    <div className="order-detail-product-item">
                      <div className="product-item-image">
                        <img src={item.image} alt="" />
                      </div>
                      <div className="product-item-infor">
                        <p className="infor-name">{item.name}</p>
                        <div className="infor-price-quantity">
                          <p className="infor-price">
                            {item.price}
                          </p>
                          <p className="px-2">
                            x
                          </p>
                          <p className="infor-quantity">
                            {item.quantity}
                          </p>
                        </div>
                      </div>
                    </div>
                  )
                })
              }
            </div>
          </div>
        ) : (
          <p>Không có thông tin chi tiết đơn hàng.</p>
        )}
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleClose}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default OrderDetailModal;
