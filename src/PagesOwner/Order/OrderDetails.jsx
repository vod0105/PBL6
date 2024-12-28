import React, { useEffect, useState } from "react";

import axios from "axios";
import LoadingSpinner from "../../Action/LoadingSpiner.js";
import ModalComponent from "../../components/ModalComponent.js";
import Example from "../../components/ModalComponent.js";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBackward } from "@fortawesome/free-solid-svg-icons";
import { faForward } from "@fortawesome/free-solid-svg-icons";
import { useParams } from "react-router-dom";
import SoundNotification from "../../components/Notify/Notify.jsx";

const OrderDetail = ({ url }) => {
  const { Id } = useParams();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState(""); // Trạng thái lưu từ khóa tìm kiếm
  const itemsPerPage = 4; // Số lượng phần tử mỗi trang
  const navigate = useNavigate();
  useEffect(() => {
    const fetchData = async () => {
      try {
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };
        const response = await axios.get(
          `${url}/api/v1/owner/order/get/details?orderCode=${Id}`,
          { headers }
        );
        console.log("vao day");

        console.log("res", response.data.data);
        setData(response.data.data);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  // delete store
  const deleteProduct = async (productId) => {
    try {
      const tk = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${tk}`,
        "Content-Type": "application/json",
      };
      await axios.delete(`${url}/api/v1/admin/products/delete/${productId}`, {
        headers,
      });
      setData(data.filter((cat) => cat.productId !== productId));
      toast.success("Deleted Product Successful");
    } catch (error) {
      if (error.response) {
        console.error("Error Response Data:", error.response.data);
        toast.error(error.response.data.message || "Something went wrong.");
      } else {
        console.error("Error:", error.message);
        toast.error("Something went wrong.");
      }
    }
  };
  // chuyen huong update store
  const handleUpdateClick = (productId) => {
    // navigate(`admin/UpdateCategory/${cateId}`);
    navigate(`/admin/UpdateProduct/${productId}`);
  };
  //

  if (loading) {
    return (
      <p>
        <LoadingSpinner />
      </p>
    );
  }

  return (
    <div className="product">
      <div className="content">
        <div
          className="heading"
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
          }}
        >
          <h2 className="h-product">List Product Of Orders</h2>
          <div className="store-search">
            <input
              type="text"
              placeholder="Search Name Product"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              style={{
                padding: "5px 15px",
                outlineColor: "tomato",
              }}
            />
          </div>
        </div>
        <table
          className="table table-hover text-center align-items-center tb-product"
          style={{
            backgroundColor: "red",
            tableLayout: "fixed",
            textAlign: "center",
            verticalAlign: "center",
            boxShadow: "0 0.1rem 0.4rem #0002",
          }}
        >
          <thead
            className="table-danger text-center"
            style={{
              whiteSpace: "nowrap",
              textAlign: "center",
              verticalAlign: "center",
            }}
          >
            <tr>
              <th scope="col">orderDetailId</th>
              <th scope="col">Name</th>
              <th scope="col">Image</th>
              <th scope="col">Id</th>
              <th scope="col">Quantity</th>
              <th scope="col">Unit Price</th>
              <th scope="col">Total Price</th>
              <th scope="col">Size</th>
            </tr>
          </thead>
          <tbody className="align-middle">
            {data.length > 0 ? (
              data.map((item) => (
                <tr
                  key={
                    item.comboDetail?.orderDetailId ||
                    item.productDetail?.orderDetailId
                  }
                  style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                >
                  {/* Kiểm tra loại dữ liệu là combo hay product và hiển thị tương ứng */}
                  {item.type === "combo" ? (
                    <>
                      <td>{item.comboDetail.orderDetailId}</td>
                      <td>{item.comboDetail.comboName}</td>
                      <td>
                        <img
                          src={`${url}/api/v1/public/uploads/images/${item.comboDetail.image}`}
                          className="img-product"
                          alt="Combo Image"
                          style={{
                            height: "110px",
                            width: "110px",
                            objectFit: "contain",
                          }}
                        />
                      </td>
                      <td>{item.comboDetail.comboId}</td>
                      <td>{item.comboDetail.quantity}</td>
                      <td>{item.comboDetail.unitPrice}</td>
                      <td>{item.comboDetail.totalPrice}</td>
                      <td>{item.comboDetail.size}</td>
                    </>
                  ) : (
                    <>
                      <td>{item.productDetail.orderDetailId}</td>
                      <td>{item.productDetail.productName}</td>
                      <td>
                        <img
                          // src={`data:image/jpeg;base64,${item.productDetail.image}`}
                          src={`${url}/api/v1/public/uploads/images/${item.productDetail.image}`}
                          className="img-product"
                          alt="Product Image"
                          style={{
                            height: "100px",
                            width: "100px",
                            objectFit: "contain",
                          }}
                        />
                      </td>
                      <td>{item.productDetail.productId}</td>
                      <td>{item.productDetail.quantity}</td>
                      <td>{item.productDetail.unitPrice}</td>
                      <td>{item.productDetail.totalPrice}</td>
                      <td>{item.productDetail.size}</td>
                    </>
                  )}
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="8">No data available</td>
              </tr>
            )}
          </tbody>
        </table>
        {/* <div
          className="pagination pagenigate-pd pd"
          style={{ marginTop: "80px" }}
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
        </div> */}
      </div>
    </div>
  );
};

export default OrderDetail;
