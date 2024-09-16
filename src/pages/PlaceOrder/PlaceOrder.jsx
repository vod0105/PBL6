import React, { useState } from "react";
import axios from "axios";
// import { toast } from "react-toastify";
import "./PlaceOrder.css";

const PlaceOrder = () => {
  const [data, setData] = useState({
    userID: "",
    amount: 1,
    address: "",
  });

  const [orderResponse, setOrderResponse] = useState(null);

  const onChangeHandler = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setData((data) => ({ ...data, [name]: value }));
  };

  const onSubmitHandler = async (event) => {
    event.preventDefault();

    try {
      // Lấy token từ localStorage hoặc nơi bạn đã lưu trữ
      const token =
        localStorage.getItem("token") ||
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YzJmYjg0ZGNiZDNhODQ5MWQ0ZWQ4MCIsImlhdCI6MTcyNDI5MzA0MX0.K0rHEANSximZif9YMlbcMvF_9gDs6Um82F-OCSx8L4E";

      const response = await axios.post(
        `http://localhost:4000/api/order/place`,
        data, // Gửi dữ liệu dưới dạng JSON
        {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (response.data.success) {
        setOrderResponse(response.data);
        console.log("Order placed successfully");
        // toast.success(response.data.message);
      } else {
        console.log("Error placing order:", response.data.message);
        // toast.error(response.data.message);
      }
    } catch (error) {
      console.error("Error placing order:", error);
      // toast.error("Error placing order");
    }
  };

  return (
    <div>
      <form onSubmit={onSubmitHandler} className="place-order">
        <div className="place-order-left">
          <p className="title">Delivery Information</p>
          <div className="multi-fields">
            <input
              type="text"
              placeholder="User ID"
              name="userID"
              value={data.userID}
              onChange={onChangeHandler}
            />
            <input
              type="text"
              placeholder="Address"
              name="address"
              value={data.address}
              onChange={onChangeHandler}
            />
            <input
              type="number"
              placeholder="Amount"
              name="amount"
              value={data.amount}
              onChange={onChangeHandler}
            />
          </div>
        </div>
        <button type="submit">Order</button>
      </form>

      {orderResponse && (
        <div className="order-details">
          <h2>Order Details</h2>
          <p>
            <strong>Order ID:</strong> {orderResponse.order._id}
          </p>
          <p>
            <strong>Amount:</strong> {orderResponse.order.amount}
          </p>
          <p>
            <strong>Address:</strong> {orderResponse.order.address}
          </p>
          <p>
            <strong>Status:</strong> {orderResponse.order.status}
          </p>
          <p>
            <strong>Food Items:</strong>
          </p>
          <ul>
            {Object.entries(orderResponse.foodNames).map(([id, name]) => (
              <li key={id}>{name}</li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default PlaceOrder;
