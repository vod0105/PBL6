import React, { useState } from 'react';
import './Orders.scss';
import OrderDetailModal from '../../components/OrderDetailModal/OrderDetailModal'; // Import Modal

const Orders = () => {
  const [showModal, setShowModal] = useState(false);
  const [orderDetails, setOrderDetails] = useState(null);

  const handleShowDetails = (order) => {
    setOrderDetails(order); // Lưu trữ thông tin đơn hàng
    setShowModal(true);
  };

  const handleClose = () => {
    setShowModal(false);
    // setOrderDetails(null); // Reset thông tin đơn hàng
  };

  const orders = [
    {
      id: '1',
      customerId: 'KH001',
      name: 'Nguyễn Văn A',
      phone: '0123456789',
      email: 'nguyenvana@gmail.com',
      address: '123 Đường ABC, Quận 1, TP HCM',
      note: 'Giao vào buổi sáng',
      orderDate: '06/10/2024',
      total: '1,330,000 đ',
      status: 3
    }
  ];

  return (
    <div className="orders-management">
      <div className="container">
        <div className="orders-management-icon">
          <i class="icon-i fa-solid fa-box-open"></i>
          <span className='icon-span'>các đơn hàng của bạn</span>
        </div>
        <table className="table table-striped table-orders">
          <thead>
            <tr>
              <th scope="col">Mã đơn hàng</th>
              <th scope="col">Ngày đặt</th>
              <th scope="col">Tổng tiền</th>
              <th scope="col">Trạng thái</th>
              <th scope="col">Xem chi tiết đơn hàng</th>
              <th scope="col">Hủy đơn hàng</th>
            </tr>
          </thead>
          <tbody>
            {orders.map((order) => (
              <tr key={order.id}>
                <th scope="row" className="text-center align-middle">{order.id}</th>
                <td className="text-center align-middle">{order.orderDate}</td>
                <td className="text-center align-middle">{order.total}</td>
                <td className="text-center align-middle">{order.status}</td>
                <td className="text-center align-middle">
                  <button
                    className="btn btn-primary"
                    onClick={() => handleShowDetails(order)}
                  >
                    Xem chi tiết
                  </button>
                </td>
                <td className="text-center align-middle">
                  <button className="btn btn-warning">Hủy</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        <button className="btn btn-dark btn-return-homepage">TRỞ LẠI TRANG CHỦ</button>
        <OrderDetailModal
          showModal={showModal}
          handleClose={handleClose}
          orderDetails={orderDetails}
        />
      </div>
    </div>
  );
};

export default Orders;
