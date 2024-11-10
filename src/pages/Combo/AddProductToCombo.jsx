import React, { useState, useEffect } from "react";
import "./AddProductToCombo.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBackward } from "@fortawesome/free-solid-svg-icons";
import { faForward } from "@fortawesome/free-solid-svg-icons";

const AddProducToComBo = ({ url }) => {
  const [image, setImage] = useState(false);
  const [data, setData] = useState([]);
  const [dataProduct, setDataProduct] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  //left
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState(""); // Trạng thái lưu từ khóa tìm kiếm
  const itemsPerPage = 4; // Số lượng phần tử mỗi trang
  const navigate = useNavigate();
  //right
  const [currentPage2, setCurrentPage2] = useState(1);
  const [searchTerm2, setSearchTerm2] = useState(""); // Trạng thái lưu từ khóa tìm kiếm
  const itemsPerPage2 = 5; // Số lượng phần tử mỗi trang

  //get store
  // const [product, SetProduct] = useState([]);
  const [SelectedStoreId, setSelectedStoreId] = useState("");
  const [SelectedProductId, setSelectedProductId] = useState("");
  const token = localStorage.getItem("access_token");
  ///

  const [selectedIds, setSelectedIds] = useState([]);

  const handleCancel = () => {
    let confirmCancel = false;
    if (selectedIds.length > 0) {
      confirmCancel = window.confirm(
        "Bạn có chắc chắn muốn bỏ chọn tất cả các checkbox không?"
      );
    }

    if (confirmCancel) {
      setSelectedIds([]); // Bỏ chọn tất cả các checkbox nếu chọn OK
    }
  };
  const handleCheckboxChange = (storeId) => {
    setSelectedIds((prevSelected) => {
      if (prevSelected.includes(storeId)) {
        // Nếu checkbox đã được chọn, bỏ chọn
        return prevSelected.filter((id) => id !== storeId);
      } else {
        // Nếu checkbox chưa được chọn
        // if (prevSelected.length < 5) {
        return [...prevSelected, storeId]; // Thêm id vào danh sách đã chọn
        // } else {
        //   alert("Bạn chỉ có thể chọn tối đa 1 Cửa hàng !");
        //   return prevSelected; // Không thêm vào nếu đã chọn 2 sản phẩm
        // }
      }
    });
  };

  //
  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/combo/all`)
        .then((response) => {
          // setStore(response.data.data);
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
          setDataProduct(response.data.data);
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

    formData.append("comboId", SelectedStoreId);
    formData.append("productIds", selectedIds);

    try {
      const response = await axios.post(
        `${url}/api/v1/admin/combo/addProduct/${SelectedStoreId}`,
        formData,
        { headers }
      );
      if (response.data.message) {
        toast.success("Add products to combo success  !");
        setTimeout(() => {
          navigate("/admin/Combo");
        }, 1500);
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
    console.log("selectedIds", selectedIds);
  });

  //left
  const filteredData = data.filter((store) =>
    store.comboName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Xác định các phần tử cần hiển thị trên trang hiện tại
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);

  // Tính toán số trang
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  //right
  const filteredData2 = dataProduct.filter((product) =>
    product.productName.toLowerCase().includes(searchTerm2.toLowerCase())
  );

  // Xác định các phần tử cần hiển thị trên trang hiện tại
  const indexOfLastItem2 = currentPage2 * itemsPerPage2;
  const indexOfFirstItem2 = indexOfLastItem2 - itemsPerPage2;
  const currentItems2 = filteredData2.slice(
    indexOfFirstItem2,
    indexOfLastItem2
  );

  // Tính toán số trang
  const totalPages2 = Math.ceil(filteredData2.length / itemsPerPage2);
  return (
    <div className="add-productToStore">
      <div className="left">
        <div className="search-store">
          <label htmlFor="">Search Combo</label>
          <input
            type="text"
            placeholder="Search Name Product"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
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
            className="table-success text-center"
            style={{
              whiteSpace: "nowrap",
              textAlign: "center",
              verticalAlign: "center",
            }}
          >
            <tr>
              <th scope="col" style={{ width: "10%" }}>
                Id
              </th>
              <th scope="col" style={{ width: "30%" }}>
                Image
              </th>
              <th scope="col" style={{ width: "30%" }}>
                Combo Name
              </th>
              <th scope="col" style={{ width: "30%" }}>
                Price
              </th>
            </tr>
          </thead>
          <tbody className="align-middle">
            {currentItems.length > 0 ? (
              currentItems.map((data) => (
                <tr
                  key={data.comboId}
                  style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                >
                  <td>
                    <input
                      type="radio"
                      name="namestore"
                      style={{ color: "black", width: "100%" }}
                      // onChange={() => handleCheckboxChange(data.storeId)}
                      // checked={selectedIds.includes(data.storeId)}
                      value={data.comboId}
                      onChange={(e) => setSelectedStoreId(e.target.value)}
                    />
                  </td>
                  <td>
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
                  </td>
                  <td>{data.comboName}</td>
                  <td>{data.price}</td>
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
          className="pagination pagenigate-pd pd-p-s"
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
          {/* <ToastContainer /> */}
        </div>
      </div>
      <div className="line"></div>
      <div className="right">
        <div className="search-store">
          <label htmlFor="">Search Product</label>
          <input
            type="text"
            placeholder="Search Name Product"
            // value={searchTerm}
            // onChange={(e) => setSearchTerm2(e.target.value)}
            value={searchTerm2}
            onChange={(e) => setSearchTerm2(e.target.value)}
          />
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
              <th scope="col" style={{ width: "10%" }}>
                Id
              </th>
              <th scope="col" style={{ width: "30%" }}>
                Image
              </th>
              <th scope="col" style={{ width: "30%" }}>
                Name Product
              </th>
              <th scope="col" style={{ width: "30%" }}>
                Quantity
              </th>
            </tr>
          </thead>
          <tbody className="align-middle">
            {currentItems2.length > 0 ? (
              currentItems2.map((data) => (
                <tr
                  key={data.productId}
                  style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                >
                  <td>
                    <input
                      type="checkbox"
                      style={{ color: "black", width: "100%" }}
                      onChange={() => handleCheckboxChange(data.productId)}
                      checked={selectedIds.includes(data.productId)}
                    />
                  </td>
                  <td>
                    <img
                      src={`data:image/jpeg;base64,${data.image}`}
                      className="img-product"
                      alt="Image cate"
                      style={{
                        height: "60px",
                        width: "60px",
                        objectFit: "contain",
                      }}
                    />
                  </td>
                  <td>{data.productName}</td>
                  <td>{data.stockQuantity}</td>
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
          className="pagination pagenigate-pd pd-p-r"
          style={{ marginTop: "80px" }}
        >
          <button
            onClick={() => setCurrentPage2((prev) => Math.max(prev - 1, 1))}
            disabled={currentPage2 === 1}
          >
            <FontAwesomeIcon icon={faBackward} />
          </button>
          {Array.from({ length: totalPages2 }, (_, index) => (
            <button
              key={index + 1}
              onClick={() => setCurrentPage2(index + 1)}
              className={currentPage2 === index + 1 ? "active" : ""}
            >
              {index + 1}
            </button>
          ))}
          <button
            onClick={() =>
              setCurrentPage2((prev) => Math.min(prev + 1, totalPages2))
            }
            disabled={currentPage2 === totalPages2}
          >
            <FontAwesomeIcon icon={faForward} />
          </button>
        </div>
        <div className="action">
          <div className="action-check action-btn">
            <button onClick={handleCancel}>Huỷ bỏ các lựa chọn </button>
          </div>

          <div className="action-right action-btn">
            <button onClick={onSubmitHandler}>Thêm vào Combo</button>
          </div>
        </div>
      </div>
      <ToastContainer position="top-right" />
    </div>
  );
};

export default AddProducToComBo;
