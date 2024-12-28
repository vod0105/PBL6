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
import ReactPaginate from "react-paginate";
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Pagination } from "@mui/material";  // MUI imports

const notificationSound = new Audio("/sound/tingting.mp3");

const Order = ({ url }) => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState("");
  const [orderStatus, setOrderStatus] = useState("Đơn hàng mới");
  const [totalPages, setTotalPages] = useState(0);
  const itemsPerPage = 5;
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
      setData(response.data.data);
      setTotalPages(response.data.page);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  };

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
      fetchData();
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
                placeholder="Search Order"
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

        <TableContainer component={Paper} style={{ width: "80%", margin: "0 auto", marginTop: "20px" }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Order Code</TableCell>
                <TableCell>Image</TableCell>
                <TableCell>Full Name</TableCell>
                <TableCell>Total Price</TableCell>
                {orderStatus === "Đơn hàng mới" && <TableCell>Action</TableCell>}
                <TableCell>Details</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {filteredData.length > 0 ? (
                filteredData.map((order) => (
                  <TableRow key={order.orderCode}>
                    <TableCell>{order.orderCode}</TableCell>
                    <TableCell>
                      <img
                        src={order.imageUser ? `data:image/jpeg;base64,${order.imageUser}` : assets.manOrder}
                        className="img-cate"
                        alt="Image cate"
                        style={{ width: "50px", height: "50px", objectFit: "cover" }}
                      />
                    </TableCell>
                    <TableCell>{order.fullName}</TableCell>
                    <TableCell>{order.totalPrice}</TableCell>
                    {orderStatus === "Đơn hàng mới" && (
                      <TableCell>
                        <IconButton
                          aria-label="accept"
                          size="medium"
                          onClick={() => handleAcceptClick(order.orderCode)}
                        >
                          <CheckBoxIcon />
                        </IconButton>
                      </TableCell>
                    )}
                    <TableCell>
                      <IconButton
                        aria-label="view details"
                        size="medium"
                        onClick={() => handleRedirect(order.orderCode)}
                      >
                        <PiEyesBold style={{ width: "35px", height: "35px" }} />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={6} align="center">
                    No data available
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </TableContainer>

        {/* MUI Pagination */}
        <div style={{ display: "flex", justifyContent: "center", marginTop: "20px" }}>
          <Pagination
            count={totalPages}
            page={currentPage}
            onChange={(event, value) => setCurrentPage(value)}
            variant="outlined"
            color="primary"
          />
        </div>

        <ToastContainer />
      </div>
    </div>
  );
};

export default Order;
