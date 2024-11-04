import React, { useEffect, useState } from "react";
import "../promotion/Promotion.css";
import axios from "axios";
import LoadingSpinner from "../../Action/LoadingSpiner.js";
import ModalComponent from "../../components/ModalComponent.js";
import Example from "../../components/ModalComponent.js";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import IconButton from "@mui/material/IconButton";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";
const Promotion = ({ url }) => {
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
        const token = localStorage.getItem("access_token");
        const response = await axios.get(`${url}/api/v1/public/promotions/all`);
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
      await axios.delete(`${url}/api/v1/admin/promotions/delete/${productId}`, {
        headers,
      });
      setData(data.filter((cat) => cat.id !== productId));
      toast.success("Deleted Promotion Successful");
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
  const handleUpdateClick = (promotionID) => {
    // navigate(`admin/UpdateCategory/${cateId}`);
    navigate(`/admin/UpdatePromotion/${promotionID}`);
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
    item.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Xác định các phần tử cần hiển thị trên trang hiện tại
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);

  // Tính toán số trang
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  return (
    <div className="promotion">
      <div className="content">
        <div
          className="heading"
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            paddingBottom: "30px",
          }}
        >
          <h1 className="h-product">List Promotion</h1>
          <div className="store-search">
            <input
              style={{ padding: 5, borderColor: "tomato", borderRadius: 5 }}
              type="text"
              placeholder="Search by store name"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
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
              <th scope="col">Id</th>
              <th scope="col">Image</th>
              <th scope="col">Promotion Name</th>
              <th scope="col">Description</th>
              <th scope="col">Discount Percentage</th>
              <th scope="col">Start Date</th>
              <th scope="col">End Date</th>
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
                  <td>{data.id}</td>
                  <td>
                    <img
                      src={`data:image/jpeg;base64,${data.image}`}
                      className="img-product"
                      alt="Image cate"
                      style={{
                        height: "80px",
                        width: "80px",
                        objectFit: "cover",
                        borderRadius: "50%",
                      }}
                    />
                  </td>
                  <td>{data.name}</td>
                  <td>{data.description}</td>
                  <td>{data.discountPercentage}</td>

                  <td>{data.startDate}</td>
                  <td>{data.endDate}</td>

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
        <div className="pagination pagenigate-pd">
          <button
            onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
            disabled={currentPage === 1}
          >
            Previous
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
            Next
          </button>
          <ToastContainer />
        </div>
      </div>
    </div>
  );
};

export default Promotion;
