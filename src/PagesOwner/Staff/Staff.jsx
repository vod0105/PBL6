import React, { useEffect, useState } from "react";
import "../Order/Order.css";
import axios from "axios";
import LoadingSpinner from "../../Action/LoadingSpiner.js";
import ModalComponent from "../../components/ModalComponent.js";
import Example from "../../components/ModalComponent.js";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBackward } from "@fortawesome/free-solid-svg-icons";
import { faForward } from "@fortawesome/free-solid-svg-icons";
import IconButton from "@mui/material/IconButton";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";
import SoundNotification from "../../components/Notify/Notify.jsx";
const StaffList = ({ url }) => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState(""); // Trạng thái lưu từ khóa tìm kiếm
  const itemsPerPage = 4; // Số lượng phần tử mỗi trang
  const navigate = useNavigate();

  const API_KEY = "5b3ce3597851110001cf62481607a0c61799494f8d6079e5c19daa68";

  const getRoute = async () => {
    try {
      const response = await axios.post(
        "https://api.openrouteservice.org/v2/directions/driving-car",
        {
          coordinates: [
            [-0.1278, 51.5074], // London (longitude, latitude)
            [-0.1537, 51.5174], // Location khác
          ],
        },
        {
          headers: {
            Authorization: `Bearer ${API_KEY}`,
          },
        }
      );
      console.log(response.data); // In ra kết quả từ API
    } catch (error) {
      console.error("Error fetching route:", error);
    }
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        getRoute();
        const token = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        };
        const response = await axios.get(`${url}/api/v1/owner/staff/store`, {
          headers,
        });
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
      await axios.delete(`${url}/api/v1/owner/staff/delete/${productId}`, {
        headers,
      });
      setData(data.filter((cat) => cat.id !== productId));
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
    navigate(`/owner/UpdateStaff/${productId}`);
  };
  //

  if (loading) {
    return (
      <p>
        <LoadingSpinner />
      </p>
    );
  }

  if (error) {
    return <p>Error: {error.message}</p>;
  }

  // Xử lý từ khóa tìm kiếm
  const filteredData = data.filter((item) =>
    item.employeeName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Xác định các phần tử cần hiển thị trên trang hiện tại
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);

  // Tính toán số trang
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

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
          <h1 className="h-product">List Staff</h1>
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
              <th scope="col">Staff Code</th>
              <th scope="col">Employee Name</th>

              <th scope="col">Department</th>
              <th scope="col">Store name</th>

              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody className="align-middle">
            {currentItems.length > 0 ? (
              currentItems.map((data) => (
                <tr
                  key={data.id}
                  style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                >
                  {/* <td>
                    <img
                      src={`data:image/jpeg;base64,${data.image}`}
                      className="img-product"
                      alt="Image cate"
                      style={{
                        height: "100px",
                        width: "100px",
                        objectFit: "contain",
                      }}
                    />
                  </td> */}
                  <td>{data.staff_code}</td>
                  <td>{data.employeeName}</td>

                  <td>{data.department}</td>
                  <td>{data.storeName}</td>

                  <td>
                    <button
                      style={{
                        border: "2px solid gray",
                        marginRight: "5px",
                        borderRadius: "50%",
                      }}
                      className="btndelete"
                      onClick={() => handleUpdateClick(data.id)}
                    >
                      <IconButton aria-label="delete" size="medium">
                        <EditIcon />
                      </IconButton>
                    </button>
                    <button
                      style={{
                        border: "2px solid gray",

                        borderRadius: "50%",
                      }}
                      className="btndelete"
                      onClick={() => deleteProduct(data.id)}
                    >
                      <IconButton aria-label="delete" size="medium">
                        <DeleteIcon />
                      </IconButton>
                    </button>
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="8">No data available</td>
              </tr>
            )}
          </tbody>
        </table>
        <div
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
        </div>
      </div>
    </div>
  );
};

export default StaffList;
