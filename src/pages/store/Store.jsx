import React, { useEffect, useState } from "react";
import "../store/Store.css";
import axios from "axios";
import LoadingSpinner from "../../Action/LoadingSpiner.js";
import ModalComponent from "../../components/ModalComponent.js";
import Example from "../../components/ModalComponent.js";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import IconButton from "@mui/material/IconButton";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBackward } from "@fortawesome/free-solid-svg-icons";
import { faForward } from "@fortawesome/free-solid-svg-icons";

const Store = ({ url }) => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState(""); // Trạng thái lưu từ khóa tìm kiếm
  const itemsPerPage = 3; // Số lượng phần tử mỗi trang
  const navigate = useNavigate();
  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem("access_token");
        const response = await axios.get(`${url}/api/v1/public/stores/all`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
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
  const deleteStore = async (storeId) => {
    try {
      const tk = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${tk}`,
      };
      await axios.delete(`${url}/api/v1/admin/stores/delete/${storeId}`, {
        headers,
      });
      setData(data.filter((store) => store.storeId !== storeId));
      toast.success("Deleted Store Successful");
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
  const filteredData = data.filter((store) =>
    store.storeName.toLowerCase().includes(searchTerm.toLowerCase())
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
          <h1 className="h1-store">List Store</h1>
          <div className="store-search">
            <input
              type="text"
              placeholder="Search by store name"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
        </div>
        {/* <table className="table text-center">
          <thead className="table-dark">
            <tr>
              <th scope="col">storeId</th>
              <th scope="col">Image</th>
              <th scope="col">storeName</th>
              <th scope="col">location</th>
              <th scope="col">managerName</th>
              <th scope="col">numberPhone</th>
              <th scope="col">openingTime</th>
              <th scope="col">Sửa</th>
              <th scope="col">Xóa</th>
            </tr>
          </thead>
          <tbody>
            {currentItems.length > 0 ? (
              currentItems.map((store) => (
                <tr key={store.storeId}>
                  <td>{store.storeId}</td>
                  <td>
                    <img
                      src={`data:image/jpeg;base64,${store.image}`}
                      className="img-product"
                      alt="Image cate"
                      style={{
                        height: "70px",
                        width: "70px",
                      }}
                    />
                  </td>
                  <td>{store.storeName}</td>
                  <td>{store.location}</td>
                  <td>{store.managerName}</td>
                  <td>{store.numberPhone}</td>
                  <td>{store.openingTime}</td>
                  <td>
                    <button
                      type="button"
                      className="btn btn-primary"
                      onClick={() => handleUpdateClick(store.storeId)}
                    >
                      Update
                    </button>
                  </td>
                  <td>
                    <button
                      type="button"
                      className="btn btn-danger"
                      onClick={() => deleteStore(store.storeId)}
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
        </table> */}
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
              <th scope="col" style={{ width: "50px" }}>
                ID
              </th>
              <th scope="col">Hình ảnh</th>
              <th scope="col">Tên cửa hàng</th>
              <th scope="col">Vị trí</th>
              <th scope="col">Thời gian mở</th>
              <th scope="col">Số điện thoại</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody className="align-middle">
            {currentItems.length > 0 ? (
              currentItems.map((store) => (
                <tr key={store.storeId}>
                  <td>{store.storeId}</td>
                  {/* api/v1/public/uploads/images/ */}
                  <td>
                    <img
                      src={`${url}/api/v1/public/uploads/images/${store.image}`}
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
                  <td>{store.storeName}</td>
                  <td>{store.location}</td>
                  <td>{store.openingTime}</td>
                  <td>{store.numberPhone}</td>
                  <td>
                    <button
                      style={{
                        border: "2px solid gray",
                        marginRight: "5px",
                        borderRadius: "50%",
                      }}
                      className="btndelete"
                      onClick={() => handleUpdateClick(store.storeId)}
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
                      onClick={() => deleteStore(store.storeId)}
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

export default Store;
