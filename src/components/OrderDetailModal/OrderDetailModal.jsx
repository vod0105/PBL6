import React, { useState, useEffect } from 'react'
import { Modal, Button } from 'react-bootstrap';
import './OrderDetailModal.scss';
const OrderDetailModal = ({ showModal, handleClose, orderDetails, statusOrderInteger }) => {
  const [listProducts, setListProducts] = useState([]);
  useEffect(() => {
    if (orderDetails) {
      setListProducts(orderDetails.orderDetails);
      console.log('>>> check list products: ', listProducts);
    }
  }, [orderDetails]);
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
                {orderDetails.orderCode}
              </p>
            </div>
            <div className="order-detail-infor">
              <div className="order-detail-infor-item">
                {/* note: DB ko có trường ni */}
                <p className="infor-title">Họ tên người nhận</p>
                <p className="infor-content">Biện Văn Nhật</p>
              </div>
              <div className="order-detail-infor-item">
                {/* note: DB ko có trường ni */}
                <p className="infor-title">Số điện thoại</p>
                <p className="infor-content">04357834755</p>
              </div>
              <div className="order-detail-infor-item">
                {/* note: DB ko có trường ni */}
                <p className="infor-title">Email</p>
                <p className="infor-content">jfsdg@gmail.com</p>
              </div>
              <div className="order-detail-infor-item">
                <p className="infor-title">Địa chỉ</p>
                <p className="infor-content">{orderDetails.deliveryAddress}</p>
              </div>
              <div className="order-detail-infor-item">
                {/* note: DB ko có trường ni */}
                <p className="infor-title">Ghi chú</p>
                <p className="infor-content">Đem nhanh nhanh nha anh Shipper</p>
              </div>
            </div>

            <div className="order-detail-status">
              {
                +statusOrderInteger === 2 ? ( // status: Hủy
                  <>
                    <div className="status-line">
                      <div className="status-segment">
                        <div className={`status-bar active`}></div>
                        <i className={`status-icon fa fa-clock active`}></i> {/* Icon Đơn hàng mới -> Đang chờ xác nhận */}
                        <div className={`status-bar active`}></div>
                      </div>
                      <div className="status-segment">
                        <div className={`status-bar active`}></div>
                        <i className={`status-icon fa-solid fa-rectangle-xmark active`}></i> {/* Icon bị hủy */}
                        <div className={`status-bar active`}></div>
                      </div>
                    </div>
                    <div className="status-labels">
                      <span>Đang chờ xác nhận</span>
                      <span>Bị hủy</span>
                    </div>
                  </>
                )
                  : (
                    <>
                      <div className="status-line">
                        <div className="status-segment">
                          <div className={`status-bar ${+statusOrderInteger >= 1 ? 'active' : ''}`}></div>
                          <i className={`status-icon fa fa-clock ${+statusOrderInteger >= 1 ? 'active' : ''}`}></i> {/* Icon cho Đang chờ xác nhận */}
                          <div className={`status-bar ${+statusOrderInteger >= 1 ? 'active' : ''}`}></div>
                        </div>
                        <div className="status-segment">
                          <div className={`status-bar ${+statusOrderInteger >= 3 ? 'active' : ''}`}></div>
                          <i className={`status-icon fa-solid fa-hourglass-start ${+statusOrderInteger >= 3 ? 'active' : ''}`}></i> {/* Icon cho Đang chuẩn bị */}
                          <div className={`status-bar ${+statusOrderInteger >= 3 ? 'active' : ''}`}></div>
                        </div>
                        <div className="status-segment">
                          <div className={`status-bar ${+statusOrderInteger >= 4 ? 'active' : ''}`}></div>
                          <i className={`status-icon fa fa-truck ${+statusOrderInteger >= 4 ? 'active' : ''}`}></i> {/* Icon cho Đang giao */}
                          <div className={`status-bar ${+statusOrderInteger >= 4 ? 'active' : ''}`}></div>
                        </div>
                        <div className="status-segment">
                          <div className={`status-bar ${+statusOrderInteger >= 5 ? 'active' : ''}`}></div>
                          <i className={`status-icon fa fa-check-circle ${+statusOrderInteger >= 5 ? 'active' : ''}`}></i> {/* Icon cho Đã giao */}
                          <div className={`status-bar ${+statusOrderInteger >= 5 ? 'active' : ''}`}></div>
                        </div>
                      </div>
                      <div className="status-labels">
                        <span>Đang chờ xác nhận</span>
                        <span>Đã xác nhận</span>
                        <span>Đang giao</span>
                        <span>Đã hoàn thành</span>
                      </div>
                    </>
                  )
              }

            </div>
            <div className="order-detail-product">
              {
                listProducts && listProducts.length > 0 ? (listProducts.map((item, index) => {
                  return (
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
                  )
                }))
                  : (
                    <div>Không có sản phẩm nào</div>
                  )
              }
            </div>
          </div >
        ) : (
          <p>Không có thông tin chi tiết đơn hàng.</p>
        )}
      </Modal.Body >
      <Modal.Footer>
        <Button variant="secondary" onClick={handleClose}>
          Đóng
        </Button>
      </Modal.Footer>
    </Modal >
  );
};

export default OrderDetailModal;
