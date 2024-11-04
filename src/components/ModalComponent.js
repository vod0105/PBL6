import React from "react";

const ModalComponent = ({ isOpen, handleClose, orderDetails }) => {
  return (
    <div
      className={`modal fade ${isOpen ? "show" : ""}`}
      style={{ display: isOpen ? "block" : "none" }}
      tabIndex="-1"
      role="dialog"
    >
      <div className="modal-dialog" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title">Order Details</h5>
            <button type="button" className="close" onClick={handleClose}>
              <span>&times;</span>
            </button>
          </div>
          <div className="modal-body">
            <p>
              <strong>Order Code:</strong> {orderDetails.orderCode}
            </p>
            <p>
              <strong>Total Price:</strong> {orderDetails.totalPrice}
            </p>
            {/* Thêm thông tin khác về đơn hàng tại đây */}
          </div>
          <div className="modal-footer">
            <button
              type="button"
              className="btn btn-secondary"
              onClick={handleClose}
            >
              Close
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ModalComponent;
