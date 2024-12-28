import React, { useEffect, useState } from "react";
import "../Product/Product2.css";
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

const Product = ({ url }) => {
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
        const response = await axios.get(`${url}/api/v1/public/products/all`);
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
    const isConfirmed = window.confirm("Are you sure you want to delete this product?");
  
    if (!isConfirmed) {
      // Nếu người dùng không xác nhận, dừng hàm
      return;
    }
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

  if (error) {
    return <p>Error: {error.message}</p>;
  }

  // Xử lý từ khóa tìm kiếm
  const filteredData = data.filter((item) =>
    item.productName.toLowerCase().includes(searchTerm.toLowerCase())
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
          <h1 className="h-product">List Product</h1>
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
              <th scope="col" style={{width:'10%'}}>Id</th>
              <th scope="col">Hình ảnh</th>
              <th scope="col">Tên</th>
              <th scope="col">Mô tả</th>
              <th scope="col">Giá</th>
              <th scope="col">Tên danh mục</th>
              <th scope="col">Số lượng</th>
              <th scope="col">Bán chạy</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody className="align-middle">
            {currentItems.length > 0 ? (
              currentItems.map((data) => (
                <tr
                  key={data.productId}
                  style={{ borderBottom: "2px solid rgb(228, 223, 223)" }}
                >
                  <td>{data.productId}</td>
                  <td>
                    <img
                      src={`${url}/api/v1/public/uploads/images/${data.image}`}
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
                  <td>{data.productName}</td>
                  <td className="block-ellipsis">{data.description}</td>

                  <td>{data.price}</td>
                  <td>{data.category.categoryName}</td>
                  <td>{data.stockQuantity}</td>
                  <td>{data.bestSale ? "Best sales" : "Normal"}</td>

                  <td>
                    <button
                      style={{
                        border: "2px solid gray",
                        marginRight: "5px",
                        borderRadius: "50%",
                      }}
                      className="btndelete"
                      onClick={() => handleUpdateClick(data.productId)}
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
                      onClick={() => deleteProduct(data.productId)}
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

export default Product;

// import * as React from "react";
// import { useEffect, useState } from "react";
// import { DataGrid, GridColDef } from "@mui/x-data-grid";
// import Paper from "@mui/material/Paper";
// import axios from "axios";
// import IconButton from "@mui/material/IconButton";
// import DeleteIcon from "@mui/icons-material/Delete";
// import EditIcon from "@mui/icons-material/Edit";
// import LoadingSpinner from "../../Action/LoadingSpiner.js";
// import { ToastContainer, toast } from "react-toastify";
// import { useNavigate } from "react-router-dom";

// const Product = ({ url }) => {
//   const [data, setData] = useState([]);
//   const [loading, setLoading] = useState(true);
//   const [error, setError] = useState(null);
//   const [searchTerm, setSearchTerm] = useState("");
//   const [paginationModel, setPaginationModel] = useState({
//     page: 0,
//     pageSize: 5,
//   });
//   const navigate = useNavigate();

//   useEffect(() => {
//     const fetchData = async () => {
//       try {
//         const response = await axios.get(`${url}/api/v1/public/products/all`);
//         setData(response.data.data);
//       } catch (err) {
//         setError(err);
//       } finally {
//         setLoading(false);
//       }
//     };

//     fetchData();
//   }, [url]);

//   const deleteProduct = async (productId) => {
//     try {
//       const headers = {
//         Authorization: `Bearer ${localStorage.getItem("access_token")}`,
//         "Content-Type": "application/json",
//       };
//       await axios.delete(`${url}/api/v1/admin/products/delete/${productId}`, {
//         headers,
//       });
//       setData(data.filter((item) => item.productId !== productId));
//       toast.success("Deleted Product Successfully");
//     } catch (error) {
//       toast.error("Error deleting product");
//     }
//   };

//   const handleUpdateClick = (productId) => {
//     navigate(`/admin/UpdateProduct/${productId}`);
//   };

//   const filteredData = data.filter((item) =>
//     item.productName.toLowerCase().includes(searchTerm.toLowerCase())
//   );

//   const columns = [
//     { field: "productId", headerName: "Product ID", width: 100 },
//     {
//       field: "image",
//       headerName: "Image",
//       width: 100,
//       renderCell: (params) => (
//         <img
//           src={`data:image/jpeg;base64,${params.value}`}
//           alt="Product"
//           style={{
//             height: "50px",
//             width: "50px",
//             objectFit: "cover",
//             borderRadius: "50%",
//           }}
//         />
//       ),
//     },
//     { field: "productName", headerName: "Name", width: 150 },
//     { field: "description", headerName: "Description", width: 200 },
//     { field: "price", headerName: "Price", width: 100 },
//     { field: "category.categoryName", headerName: "Category", width: 150 },
//     { field: "stockQuantity", headerName: "Stock Quantity", width: 130 },
//     {
//       field: "bestSale",
//       headerName: "Best Sale",
//       width: 120,
//       renderCell: (params) => (params.value ? "Best Sale" : "Normal"),
//     },
//     {
//       field: "actions",
//       headerName: "Actions",
//       width: 150,
//       renderCell: (params) => (
//         <>
//           <IconButton onClick={() => handleUpdateClick(params.row.productId)}>
//             <EditIcon />
//           </IconButton>
//           <IconButton onClick={() => deleteProduct(params.row.productId)}>
//             <DeleteIcon />
//           </IconButton>
//         </>
//       ),
//       sortable: false,
//     },
//   ];

//   return (
//     <div className="product">
//       <div className="content">
//         <Paper sx={{ height: 540, width: "100%" }}>
//           {loading ? (
//             <LoadingSpinner />
//           ) : error ? (
//             <p>Error: {error.message}</p>
//           ) : (
//             <>
//               <div style={{ padding: "16px" }}>
//                 <input
//                   type="text"
//                   placeholder="Search Product Name"
//                   value={searchTerm}
//                   onChange={(e) => setSearchTerm(e.target.value)}
//                   style={{
//                     padding: "8px",
//                     outlineColor: "tomato",
//                     width: "100%",
//                     maxWidth: "300px",
//                   }}
//                 />
//               </div>
//               <DataGrid
//                 rows={filteredData}
//                 columns={columns}
//                 getRowId={(row) => row.productId}
//                 paginationModel={paginationModel}
//                 onPaginationModelChange={setPaginationModel}
//                 pageSizeOptions={[5, 10]}
//                 checkboxSelection
//                 sx={{
//                   "& .MuiDataGrid-row": {
//                     marginBottom: "8px",
//                     padding: "8px",
//                   },
//                   "& .MuiDataGrid-columnHeaders": {
//                     backgroundColor: "green", // Change header background color
//                     color: "black", // Change header text color
//                   },
//                 }}
//               />
//               <ToastContainer />
//             </>
//           )}
//         </Paper>
//       </div>
//     </div>
//   );
// };

// export default Product;
