import React, { useEffect, useState } from "react";
import "../CateGory/Category.css";
import axios from "axios";
import LoadingSpinner from "../../Action/LoadingSpiner.js";
import ModalComponent from "../../components/ModalComponent.js";
import Example from "../../components/ModalComponent.js";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
const Category = ({ url }) => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState(""); // Trạng thái lưu từ khóa tìm kiếm
  const itemsPerPage = 2; // Số lượng phần tử mỗi trang
  const navigate = useNavigate();
  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem("access_token");
        const response = await axios.get(`${url}/api/v1/public/categories/all`);
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
  const deleteStore = async (storeId) => {
    try {
      const tk = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${tk}`,
        'Content-Type': 'application/json'
      };
      await axios.delete(`${url}/api/v1/admin/categories/delete/${storeId}`, {
        headers,
      });
      setData(data.filter((cat) => cat.categoryId !== storeId));
      toast.success("Deleted Category Successful");
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
  const handleUpdateClick = (storeId) => {
    navigate(`/UpdateStore/${storeId}`);
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
    item.categoryName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Xác định các phần tử cần hiển thị trên trang hiện tại
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);

  // Tính toán số trang
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  return (
    <div className="store">
      <div className="content">
        <div className="heading">
          <h1>List Category</h1>
          <div className="store-search">
            <input
              type="text"
              placeholder="Search by store name"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
        </div>
        <table className="table text-center">
          <thead className="table-dark">
            <tr>
              <th scope="col">CategoryId</th>
              <th scope="col">Image</th>
              <th scope="col">categoryName</th>
              <th scope="col">description</th>
              <th scope="col">Sửa</th>
              <th scope="col">Xóa</th>
            </tr>
          </thead>
          <tbody>
            {currentItems.length > 0 ? (
              currentItems.map((data) => (
                <tr key={data.categoryId}>
                  <td>{data.categoryId}</td>
                  <td>
                    <img
                      src={`data:image/jpeg;base64,${data.image}`}
                      className="img-cate"
                      alt="Image cate"
                    />
                  </td>
                  <td>{data.categoryName}</td>
                  <td>{data.description}</td>
                  <td>
                    <button
                      type="button"
                      className="btn btn-primary"
                      onClick={() => handleUpdateClick(data.categoryId)}
                    >
                      Update
                    </button>
                  </td>
                  <td>
                    <button
                      type="button"
                      className="btn btn-danger"
                      onClick={() => deleteStore(data.categoryId)}
                    >
                      Delete
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
        <div className="pagination">
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

export default Category;
