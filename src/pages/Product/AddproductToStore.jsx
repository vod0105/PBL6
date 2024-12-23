import React, { useState, useEffect } from "react";
import "./AddProductToStorev2.css";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBackward, faForward } from "@fortawesome/free-solid-svg-icons";
import "react-toastify/dist/ReactToastify.css";

const AddProducToStore = ({ url }) => {
  const [data, setData] = useState([]); // Dữ liệu cửa hàng
  const [dataProduct, setDataProduct] = useState([]); // Dữ liệu sản phẩm
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Trạng thái phân trang và tìm kiếm cho cửa hàng (left)
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState("");
  const itemsPerPage = 4;

  // Trạng thái phân trang và tìm kiếm cho sản phẩm (right)
  const [currentPage2, setCurrentPage2] = useState(1);
  const [searchTerm2, setSearchTerm2] = useState("");
  const itemsPerPage2 = 5;

  // Trạng thái chọn cửa hàng
  const [SelectedStoreId, setSelectedStoreId] = useState("");

  // Trạng thái chọn sản phẩm và số lượng
  const [selectedIds, setSelectedIds] = useState([]);
  const [selectedQuantity, setSelectedQuantity] = useState({});

  const navigate = useNavigate();
  const token = localStorage.getItem("access_token");

  // Hàm giảm số lượng
  const handleDecrement = (id) => {
    setSelectedQuantity((prevQty) => ({
      ...prevQty,
      [id]: Math.max(1, prevQty[id] - 1),
    }));
  };

  // Hàm tăng số lượng
  const handleIncrement = (id) => {
    const product = dataProduct.find((p) => p.productId === id);
    if (!product) return;
    setSelectedQuantity((prevQty) => ({
      ...prevQty,
      [id]: Math.min(product.stockQuantity, prevQty[id] + 1),
    }));
  };

  // Hàm hủy bỏ chọn tất cả
  const handleCancel = () => {
    if (selectedIds.length > 0) {
      const confirmCancel = window.confirm(
        "Bạn có chắc chắn muốn bỏ chọn tất cả các checkbox không?"
      );
      if (confirmCancel) {
        setSelectedIds([]);
        setSelectedQuantity({});
      }
    }
  };

  // Hàm thay đổi checkbox sản phẩm
  const handleCheckboxChange = (idProduct) => {
    const product = dataProduct.find((p) => p.productId === idProduct);
    if (!product) return;

    setSelectedIds((prevSelected) => {
      if (prevSelected.includes(idProduct)) {
        // Bỏ chọn sản phẩm
        const { [idProduct]: _, ...newQuantities } = selectedQuantity;
        setSelectedQuantity(newQuantities);
        // const pvs = prevSelected.filter((id) => id !== idProduct);
        // console.log("pvs", pvs);
        return prevSelected.filter((id) => id !== idProduct);
      } else {
        // Chọn sản phẩm và khởi tạo số lượng là 1
        setSelectedQuantity((prevQty) => ({
          ...prevQty,
          [idProduct]: 1,
        }));
        return [...prevSelected, idProduct];
      }
    });
  };

  // Hàm thay đổi số lượng nhập vào
  const handleQuantityChange = (idProduct, newQuantity) => {
    const quantity = parseInt(newQuantity, 10);
    if (isNaN(quantity) || quantity < 1) {
      toast.error("Số lượng phải là số nguyên lớn hơn hoặc bằng 1.");
      setSelectedQuantity((prevQty) => ({
        ...prevQty,
        [idProduct]: 1,
      }));
      return;
    }

    const product = dataProduct.find((p) => p.productId === idProduct);
    if (!product) return;

    const validQuantity = Math.min(quantity, product.stockQuantity);

    setSelectedQuantity((prevQty) => ({
      ...prevQty,
      [idProduct]: validQuantity,
    }));
  };

  // Fetch dữ liệu cửa hàng
  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/stores/all`, { headers })
        .then((response) => {
          setData(response.data.data);
          setLoading(false);
        })
        .catch((error) => {
          console.error("There was an error fetching stores!", error);
          setError(error);
          setLoading(false);
        });
    } else {
      console.error("Access token is missing");
      setLoading(false);
    }
  }, [url, token]);

  // Fetch dữ liệu sản phẩm
  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/products/all`, { headers })
        .then((response) => {
          setDataProduct(response.data.data);
          setLoading(false);
        })
        .catch((error) => {
          console.error("There was an error fetching products!", error);
          setError(error);
          setLoading(false);
        });
    } else {
      console.error("Access token is missing");
      setLoading(false);
    }
  }, [url, token]);

  // Hàm gửi dữ liệu lên API
  const onSubmitHandler = async (event) => {
    event.preventDefault();

    const tk = localStorage.getItem("access_token");

    if (!tk) {
      toast.error("Access token is missing");
      return;
    }

    const headers = {
      Authorization: `Bearer ${tk}`,
      "Content-Type": "application/json",
    };

    const payload = {
      storeId: SelectedStoreId,
      productIds: selectedIds,
      quantity: selectedIds.map((id) => selectedQuantity[id]),
    };
    console.log("------------");
    console.log("storeId", payload.storeId);
    console.log("productIds", payload.productIds.join(","));
    console.log("quantity", payload.quantity.join(","));
    console.log("headers", headers);
    console.log("------------");
    // const data = new FormData();
    // data.append("storeId", payload.storeId);
    // data.append("productIds", payload.productIds.join(","));
    // data.append("quantity", payload.quantity.join(","));
    try {
      const response = await axios.post(
        `${url}/api/v1/admin/products/apply-list-products-to-stores`,
        {
          storeId: payload.storeId,
          productIds: payload.productIds,
          quantity: payload.quantity,
        },
        { headers }
      );
      if (response.data.message) {
        toast.success("Add Product Success!");
        setTimeout(() => {
          setSelectedStoreId("");
          setSelectedIds([]);
          setSelectedQuantity({});
          navigate("/admin/product");
        }, 1500);
      } else {
        toast.error(response.data.message || "Có lỗi xảy ra o else1 .");
      }
    } catch (error) {
      if (error.response) {
        console.error("Error Response Data:", error.response.data);
        toast.error(error.response.data.message || "Có lỗi xảy ra.");
      } else {
        console.error("Error:", error.message);
        // toast.error("Có lỗi xảy ra.");
      }
    }
  };

  // Hiển thị log trạng thái
  useEffect(() => {
    console.log("SelectedStoreId", SelectedStoreId);
    console.log("selectedIds", selectedIds);
    console.log("selectedQuantity", selectedQuantity);
  }, [SelectedStoreId, selectedIds, selectedQuantity]);

  // Lọc dữ liệu cửa hàng theo tìm kiếm
  const filteredData = data.filter((store) =>
    store.storeName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Xác định các phần tử cần hiển thị trên trang hiện tại (cửa hàng)
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);

  // Tính toán số trang (cửa hàng)
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  // Lọc dữ liệu sản phẩm theo tìm kiếm
  const filteredData2 = dataProduct.filter((product) =>
    product.productName.toLowerCase().includes(searchTerm2.toLowerCase())
  );

  // Xác định các phần tử cần hiển thị trên trang hiện tại (sản phẩm)
  const indexOfLastItem2 = currentPage2 * itemsPerPage2;
  const indexOfFirstItem2 = indexOfLastItem2 - itemsPerPage2;
  const currentItems2 = filteredData2.slice(
    indexOfFirstItem2,
    indexOfLastItem2
  );

  // Tính toán số trang (sản phẩm)
  const totalPages2 = Math.ceil(filteredData2.length / itemsPerPage2);

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Đã xảy ra lỗi: {error.message}</div>;
  }

  return (
    <div className="add-productToStore1">
      {/* Cửa hàng (left) */}
      <div className="left">
        <div>
          <div className="search-store">
            <label htmlFor="">Search Store</label>
            <input
              type="text"
              placeholder="Search Store Name"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
          <table
            className="table table-hover text-center align-items-center tb-product"
            style={{
              backgroundColor: "#f8f9fa",
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
                  Chọn
                </th>
                <th scope="col" style={{ width: "30%" }}>
                  Image
                </th>
                <th scope="col" style={{ width: "30%" }}>
                  Store Name
                </th>
                <th scope="col" style={{ width: "30%" }}>
                  Manager Name
                </th>
              </tr>
            </thead>
            <tbody className="align-middle">
              {currentItems.length > 0 ? (
                currentItems.map((store) => (
                  <tr
                    key={store.storeId}
                    style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                  >
                    <td>
                      <input
                        type="radio"
                        name="namestore"
                        style={{ color: "black", width: "100%" }}
                        value={store.storeId}
                        onChange={(e) => setSelectedStoreId(e.target.value)}
                        checked={SelectedStoreId === store.storeId.toString()}
                      />
                    </td>
                    <td>
                      <img
                        src={`${url}/api/v1/public/uploads/images/${store.image}`}
                        className="img-product"
                        alt="Store"
                        style={{
                          height: "100px",
                          width: "100px",
                          objectFit: "contain",
                        }}
                      />
                    </td>
                    <td>{store.storeName}</td>
                    <td>{store.managerName}</td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan="4">No data available</td>
                </tr>
              )}
            </tbody>
          </table>
          <div
            className="pagination pagenigate-pd pd-p-s"
            style={{ marginTop: "90px" }}
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
          </div>

          {/* Cửa hàng chỉ chọn một nên không cần nút "Huỷ bỏ lựa chọn" ở đây */}
        </div>
      </div>

      <div className="line"></div>

      {/* Sản phẩm (right) */}
      <div className="right">
        <div>
          <div className="search-store">
            <label htmlFor="">Search Product</label>
            <input
              type="text"
              placeholder="Search Product Name"
              value={searchTerm2}
              onChange={(e) => setSearchTerm2(e.target.value)}
            />
          </div>
          <table
            className="table table-hover text-center align-items-center tb-product"
            style={{
              backgroundColor: "#f8f9fa",
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
                  Chọn
                </th>
                <th scope="col" style={{ width: "20%" }}>
                  ID Product
                </th>
                <th scope="col" style={{ width: "35%" }}>
                  Image
                </th>
                <th scope="col" style={{ width: "30%" }}>
                  Name Product
                </th>
                <th scope="col" style={{ width: "35%" }}>
                  Quantity
                </th>
              </tr>
            </thead>
            <tbody className="align-middle">
              {currentItems2.length > 0 ? (
                currentItems2.map((product) => (
                  <tr
                    key={product.productId}
                    style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                  >
                    <td>
                      <input
                        type="checkbox"
                        style={{ color: "black", width: "100%" }}
                        onChange={() => handleCheckboxChange(product.productId)}
                        checked={selectedIds.includes(product.productId)}
                      />
                    </td>
                    <td>{product.productId}</td>
                    <td>
                      <img
                        src={`${url}/api/v1/public/uploads/images/${product.image}`}
                        className="img-product"
                        alt="Product"
                        style={{
                          height: "60px",
                          width: "60px",
                          objectFit: "contain",
                        }}
                      />
                    </td>
                    <td>{product.productName}</td>
                    <td className="inp-action">
                      <div className="input-group">
                        <button
                          type="button"
                          onClick={() => handleDecrement(product.productId)}
                          disabled={!selectedIds.includes(product.productId)}
                        >
                          -
                        </button>
                        <input
                          type="number"
                          max={product.stockQuantity}
                          min={1}
                          value={
                            selectedIds.includes(product.productId)
                              ? selectedQuantity[product.productId]
                              : 1
                          }
                          onChange={(e) =>
                            handleQuantityChange(
                              product.productId,
                              e.target.value
                            )
                          }
                          disabled={!selectedIds.includes(product.productId)}
                        />
                        <button
                          type="button"
                          onClick={() => handleIncrement(product.productId)}
                          className="btn2"
                          disabled={!selectedIds.includes(product.productId)}
                        >
                          +
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan="5">No data available</td>
                </tr>
              )}
            </tbody>
          </table>
          <div
            className="pagination pagenigate-pd pd-p-r"
            style={{ marginTop: "70px" }}
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
              <button type="button" onClick={handleCancel}>
                Huỷ bỏ các lựa chọn
              </button>
            </div>
            <div className="action-right action-btn">
              <button type="submit" onClick={onSubmitHandler}>
                Thêm vào cửa hàng
              </button>
            </div>
          </div>
        </div>
      </div>
      <ToastContainer position="top-right" />
    </div>
  );
};

export default AddProducToStore;
