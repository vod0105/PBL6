import React, { useState, useEffect } from "react";
import "./AddproductToStore.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
const AddProducToStore = ({ url }) => {
  const [image, setImage] = useState(false);
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState(""); // Trạng thái lưu từ khóa tìm kiếm
  const itemsPerPage = 3; // Số lượng phần tử mỗi trang
  const navigate = useNavigate();

  //get store
  const [store, setStore] = useState([]);
  const [product, SetProduct] = useState([]);
  const [SelectedStoreId, setSelectedStoreId] = useState("");
  const [SelectedProductId, setSelectedProductId] = useState("");
  const token = localStorage.getItem("access_token");

  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/stores/all`)
        .then((response) => {
          setStore(response.data.data);
          setData(response.data.data);
        })
        .catch((error) => {
          console.error("There was an error fetching users!", error);
        });
    } else {
      console.error("Access token is missing");
    }
  }, []);
  //

  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/products/all`)
        .then((response) => {
          SetProduct(response.data.data);
        })
        .catch((error) => {
          console.error("There was an error fetching users!", error);
        });
    } else {
      console.error("Access token is missing");
    }
  }, []);

  const onChangeHandler = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setData((data) => ({ ...data, [name]: value }));
  };

  const onSubmitHandler = async (event) => {
    event.preventDefault();
    const tk = localStorage.getItem("access_token");

    if (!tk) {
      toast.error("Access token is missing");
      return;
    }

    const headers = {
      Authorization: `Bearer ${tk}`,
    };

    const formData = new FormData();

    formData.append("storeId", SelectedStoreId);
    formData.append("productId", SelectedProductId);

    try {
      const response = await axios.post(
        `${url}/api/v1/admin/products/apply-to-store`,
        formData,
        { headers }
      );
      if (response.data.status) {
        // setData({
        //   categoryName: "",
        //   description: "",
        //   productName: "",
        //   price: "",
        //   description: "",
        //   categoryId: "",
        //   stockQuantity: "",
        //   bestSale: "",
        // });
        // setImage(null);
        toast.success(response.data.message);
      } else {
        toast.error(response.data.message);
      }
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
  useEffect(() => {
    // console.log("store", store);
    console.log("SelectedStoreId", SelectedStoreId);
    console.log("productid", SelectedProductId);
  });
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
    <div className="add">
      <div className="cover-left1 product-to-store">
        <h2 className="">Add Product To Store </h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <table className="form-table">
            <tbody>
              <tr>
                <td>Select Store</td>
                <td>
                  <select
                    className="ip"
                    onChange={(e) => setSelectedStoreId(e.target.value)}
                    name="Manager1"
                  >
                    <option value="">-- Select Store --</option>
                    {store.map((vl) => (
                      <option key={vl.storeId} value={vl.storeId}>
                        {vl.storeName}
                      </option>
                    ))}
                  </select>
                </td>
              </tr>
              <tr>
                <td>Select Product</td>
                <td>
                  <select
                    className="ip"
                    onChange={(e) => setSelectedProductId(e.target.value)}
                    name="Manager"
                  >
                    <option value="">-- Select Product --</option>
                    {product.map((vl) => (
                      <option key={vl.productId} value={vl.productId}>
                        {vl.productName}
                      </option>
                    ))}
                  </select>
                </td>
              </tr>
            </tbody>
          </table>

          <button className="add-btn" type="submit">
            Add
          </button>
        </form>
      </div>
      {/* <div className="cover-right">
        <div className="content-right-product-store">
          <div className="content-product-store">
            <div className="cover-head">
              <h3>Product of Store</h3>
              <input type="text" />
            </div>
            <table className="table text-center">
              <thead className="table-dark">
                <tr>
                  <th scope="col">storeId</th>
                  <th scope="col">storeName</th>
                  <th scope="col">location</th>

                  <th scope="col">Sửa</th>
                  <th scope="col">Xóa</th>
                </tr>
              </thead>
              <tbody>
                {currentItems.length > 0 ? (
                  currentItems.map((store) => (
                    <tr key={store.storeId}>
                      <td>{store.storeId}</td>
                      <td>{store.storeName}</td>
                      <td>{store.location}</td>

                      <td>
                        <button
                          type="button"
                          className="btn btn-primary"
                          // onClick={() => handleUpdateClick(store.storeId)}
                        >
                          Update
                        </button>
                      </td>
                      <td>
                        <button
                          type="button"
                          className="btn btn-danger"
                          // onClick={() => deleteStore(store.storeId)}
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
                <tr>
                <div className="pagination product-to-store">
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
                </tr>
              </tbody>
             
            </table>
          
          </div>
        </div>
      </div> */}
      <ToastContainer />
    </div>
  );
};

export default AddProducToStore;
