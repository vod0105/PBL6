import React, { useEffect, useState } from "react";
import "../Order/Order.css";
import axios from "axios";
import LoadingSpinner from "../../Action/LoadingSpiner.js";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBackward, faForward } from "@fortawesome/free-solid-svg-icons";
import SoundNotification from "../../components/Notify/Notify.jsx";
import { assets } from "../../assets/assets.js";
import IconButton from "@mui/material/IconButton";
import CheckBoxIcon from "@mui/icons-material/CheckBox";
import { PiEyesBold } from "react-icons/pi";
const notificationSound = new Audio("/sound/tingting.mp3");
const Order = ({ url }) => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState("");
  const [orderStatus, setOrderStatus] = useState("Đơn hàng mới");
  const [totalPages, setTotalPages] = useState(0);
  const itemsPerPage = 6;
  const navigate = useNavigate();

  const fetchData = async () => {
    try {
      const tk = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${tk}`,
        "Content-Type": "application/json",
      };
      const response = await axios.get(
        `${url}/api/v1/owner/order/order/status?status=${orderStatus}&page=${
          currentPage - 1
        }&size=${itemsPerPage}`,
        { headers }
      );

      console.log(
        `${url}/api/v1/owner/order/order/status?status=${orderStatus}&page=${
          currentPage - 1
        }&size=${itemsPerPage}`
      );
      setData(response.data.data);
      setTotalPages(response.data.page);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  };

  //
  // useEffect(() => {
  //   // Thiết lập hẹn giờ để phát âm thanh sau 3 giây
  //   const timer = setTimeout(() => {
  //     const speech = new SpeechSynthesisUtterance("Có đơn hàng mới");
  //     speech.lang = "vi-VN";
  //     window.speechSynthesis.speak(speech);
  //     notificationSound.play().catch((error) => {
  //       console.error("Lỗi phát âm thanh:", error);
  //     });
  //   }, 3000);

  //   return () => clearTimeout(timer);
  // }, []);
  // //

  //thong bao don hang

  useEffect(() => {});

  //

  useEffect(() => {
    fetchData();
  }, [currentPage, orderStatus]);

  const handleRedirect = (Id) => {
    navigate(`/owner/OrderDetails/${Id}`);
  };

  const handleAcceptClick = async (orderCode) => {
    if (orderStatus !== "Đơn hàng mới") {
      toast.warning("Chỉ có thể chấp nhận đơn hàng mới.");
      return;
    }
    try {
      const tk = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${tk}`,
        "Content-Type": "application/json",
      };

      const response = await axios.put(
        `${url}/api/v1/owner/order/update-status`,
        null,
        {
          headers: headers,
          params: {
            status: "Đơn hàng đã được xác nhận",
            orderCode: orderCode,
          },
        }
      );

      toast.success("Cập nhật trạng thái đơn hàng thành công");
      fetchData(); // Fetch lại dữ liệu sau khi cập nhật trạng thái
    } catch (err) {
      console.error("Error:", err.response?.data || err.message);
      toast.error("Cập nhật trạng thái đơn hàng thất bại");
    }
  };

  if (loading) {
    return <LoadingSpinner />;
  }

  if (error) {
    return <p>Error: {error.message}</p>;
  }

  // Lọc dữ liệu theo searchTerm
  const filteredData = Array.isArray(data)
    ? data.filter((item) =>
        item.orderCode.toLowerCase().includes(searchTerm.toLowerCase())
      )
    : [];
  return (
    <div className="product">
      <SoundNotification url={url} />
      <div className="content">
        <div
          className="heading"
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            width: "100%",
          }}
        >
          <h1 className="h-product">List Order</h1>
          <div className="order__action">
            <section className="order__action--cover">
              <label htmlFor="">Tìm kiếm</label>
              <input
                type="text"
                placeholder="Search Name Product"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                style={{ padding: "5px 15px", outlineColor: "tomato" }}
              />
            </section>
            <select
              name="order_select"
              className="order_select"
              value={orderStatus}
              onChange={(e) => setOrderStatus(e.target.value)}
            >
              <option value="Đơn hàng mới">Đơn hàng đang chờ</option>
              <option value="Đơn hàng đã được xác nhận">
                Lịch sử xác nhận
              </option>
              <option value="Đơn hàng đã bị hủy">Đơn hàng đã hủy</option>
            </select>
          </div>
        </div>

        <table
          className="table table-hover text-center align-items-center tb-product"
          style={{ width: "80%", margin: "0 auto", marginTop: "20px" }}
        >
          <thead className="table-danger text-center">
            <tr>
              <th scope="col">Order Code</th>
              <th scope="col">Image</th>
              <th scope="col">Full Name</th>
              <th scope="col">Total Price</th>
              {orderStatus === "Đơn hàng mới" && <th scope="col">Action</th>}
              <th scope="col">Details</th>
            </tr>
          </thead>
          <tbody className="align-middle">
            {filteredData.length > 0 ? (
              filteredData.map((order) => (
                <tr
                  key={order.orderCode}
                  style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                >
                  <td>{order.orderCode}</td>
                  <td>
                    <img
                      src={
                        order.imageUser
                          ? `data:image/jpeg;base64,${order.imageUser}`
                          : assets.manOrder
                      }
                      className="img-cate"
                      alt="Image cate"
                      style={{
                        width: "75px",
                        height: "75px",
                        objectFit: "contain",
                      }}
                    />
                  </td>
                  <td>{order.fullName}</td>
                  <td>{order.totalPrice}</td>
                  {orderStatus === "Đơn hàng mới" && (
                    <td>
                      <button
                        type="button"
                        style={{ border: "none", outline: "none" }}
                        onClick={() => handleAcceptClick(order.orderCode)}
                      >
                        <IconButton aria-label="delete" size="medium">
                          <CheckBoxIcon />
                        </IconButton>
                      </button>
                    </td>
                  )}

                  <td>
                    <button
                      type="button"
                      style={{
                        border: "none",
                        outline: "none",
                      }}
                      onClick={() => handleRedirect(order.orderCode)}
                    >
                      <PiEyesBold style={{ width: "35px", height: "35px" }} />
                    </button>
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="6">No data available</td>
              </tr>
            )}
          </tbody>
        </table>

        <div
          className="pagination pagenigate-pd pd"
          style={{ marginTop: "80px", marginLeft: "-100px" }}
        >
          <button
            onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
            disabled={currentPage === 1}
          >
            <FontAwesomeIcon icon={faBackward} />
          </button>
          {Array.from({ length: totalPages }, (_, index) => (
            <button
              key={index + 1}
              onClick={() => setCurrentPage(index + 1)}
              className={currentPage === index + 1 ? "active" : ""}
            >
              {index + 1}
            </button>
          ))}
          <button
            onClick={() =>
              setCurrentPage((prev) => Math.min(prev + 1, totalPages))
            }
            disabled={currentPage === totalPages}
          >
            <FontAwesomeIcon icon={faForward} />
          </button>
          <ToastContainer />
        </div>
      </div>
    </div>
  );
};

export default Order;
// import React, { useEffect } from "react";

// // Khởi tạo đối tượng Audio
// const notificationSound = new Audio("/sound/tingting.mp3");

// const Order = () => {
//   useEffect(() => {
//     // Thiết lập hẹn giờ để phát âm thanh sau 3 giây
//     const timer = setTimeout(() => {
//       notificationSound.play().catch((error) => {
//         console.error("Lỗi phát âm thanh:", error);
//       });
//     }, 3000);

//     // Hủy timer nếu component bị unmount
//     return () => clearTimeout(timer);
//   }, []);

//   return <div>Đang phát âm thanh sau 3 giây...</div>;
// };

// export default Order;
