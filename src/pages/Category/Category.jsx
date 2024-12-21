import React, { useState, useEffect } from "react";
import './Category.scss';
import ProductItem from "../../components/ProductItem/ProductItem";
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { fetchProductsByIdCategory } from "../../redux/actions/productActions";
import Pagination from 'react-bootstrap/Pagination';
import axios from 'axios';
import { toast } from "react-toastify";
import MoonLoader from 'react-spinners/MoonLoader';


export default function Category() {
  const { id } = useParams();
  const dispatch = useDispatch();
  const listProducts = useSelector((state) => state.product.listProductsByIdCategory);
  const isLoading = useSelector((state) => state.product.isLoadingListProductsByIdCategory);
  // State -> trang hiện tại
  const [activePage, setActivePage] = useState(1);
  const itemsPerPage = 8; // Số sản phẩm mỗi trang
  const totalPages = Math.ceil(listProducts.length / itemsPerPage); // Tổng số trang
  // State cho AI + search + select
  const [searchTerm, setSearchTerm] = useState('');
  const [searchTermAI, setSearchTermAI] = useState('');
  const [selectedSort, setSelectedSort] = useState("default");

  useEffect(() => {
    window.scrollTo(0, 0);
    dispatch(fetchProductsByIdCategory(id));
  }, [id, dispatch]); // 'id' category thay đổi -> lấy lại list products

  // Thay đổi từ khóa tìm kiếm
  const handleSearchChange = (event) => {
  setSearchTerm(event.target.value);
    setActivePage(1); // Reset về trang 1 khi tìm kiếm mới
  };

  // Thay đổi sắp xếp
  const handleSortChange = (event) => {
    setSelectedSort(event.target.value);
    setActivePage(1); // Reset về trang 1 khi thay đổi sắp xếp
  };

  // Lọc và sắp xếp sản phẩm theo từ khóa và giá (search & select)
  const filteredProducts = listProducts
    .filter((product) =>
      product.productName.toLowerCase().includes(searchTerm.toLowerCase()) &&
      product.productName.toLowerCase().includes(searchTermAI.toLowerCase())
    )
    .sort((a, b) => {
      if (selectedSort === "asc") return a.discountedPrice - b.discountedPrice;
      if (selectedSort === "desc") return b.discountedPrice - a.discountedPrice;
      return 0; // Mặc định
    });

  // Lấy list sản phẩm cho trang hiện tại
  const currentProducts = filteredProducts.slice(
    (activePage - 1) * itemsPerPage,
    activePage * itemsPerPage
  );

  // Nhấn vào một trang
  const handlePageChange = (pageNumber) => {
    setActivePage(pageNumber);
  };

  // Nhấn nút Previous
  const handlePrevious = () => {
    if (activePage > 1) {
      setActivePage(activePage - 1);
    }
  };

  // Nhấn nút Next
  const handleNext = () => {
    if (activePage < totalPages) {
      setActivePage(activePage + 1);
    }
  };

  // State để lưu trữ URL preview của hình ảnh
  const [previewImage, setPreviewImage] = useState(null);
  // Image -> base64
  const handleFileChange = (event) => {
    const file = event.target.files[0];
    return new Promise((resolve, reject) => {
      if (file) {
        const reader = new FileReader(); // FileReader hoạt động Asynchronous
        reader.onloadend = () => {
          const base64String = reader.result.split(",")[1]; // Chuyển thành base64
          resolve(base64String); // Trả về chuỗi base64
          setPreviewImage(reader.result);
        };
        reader.onerror = (error) => reject(error);
        reader.readAsDataURL(file); // Async -> Trả về chuỗi Data URL (chuỗi Base64 + tiền tố MIME: data:image/png;base64).
        // readAsText, readAsArrayBuffer, readAsDataURL
      } else {
        reject("No file selected");
      }
    });
  };
  // AI file upload
  const onFileSelected = async (event) => {
    try {
      const base64FileImage = await handleFileChange(event);
      // AI: Tìm product bằng AI -> upload file
      try {
        let urlAI = import.meta.env.VITE_AI_URL || `http://localhost:5000`;
        const responseAI = await axios.post(`${urlAI}/predict`, {
          image: base64FileImage
        });
        // console.log("response AI:", responseAI);
        if (responseAI?.data) {
          const nameProduct = responseAI.data;
          // setSearchTermAI(nameProduct);
          setSearchTerm(nameProduct);
        }
      } catch (err) {
        toast.error('Có lỗi ở Server!');
        console.error("Error details: ", err);
      }
    } catch (error) {
      console.error("Error converting file to base64:", error);
    }
  };

  return (
    <div className="page-category">
      <div className="search-filter-container">

        {/* AI */}
        <div className="file-upload-AI-container">
          <input
            type="file"
            id="file-input"
            accept="image/*"
            onChange={onFileSelected}
            style={{ display: "none" }}
          />
          <label htmlFor="file-input" className="image-upload-label">
            {
              previewImage ? (
                <img
                  src={previewImage}
                  alt="Preview"
                  className="image-preview"
                />
              ) : (
                <div className="image-upload-placeholder">
                  {/* <i className="fa-solid fa-robot"></i> */}
                  AI
              </div>
              )
            }
          </label>
          {/* <label htmlFor="file-input">
            <i className="fa-solid fa-robot"></i>
            AI
          </label> */}
        </div>

        <div className="search-container">
          <div className="row">
            <div className="col-md-12">
              <div className="input-group">
                <input
                  className="form-control border-end-0 border"
                  type="search"
                  value={searchTerm}
                  onChange={handleSearchChange}
                  placeholder="Tìm kiếm tên sản phẩm"
                />

                <span className="input-group-append">
                  <button className="btn btn-outline-secondary bg-white border ms-n5" type="button">
                    <i className="fa fa-search"></i>
                  </button>
                </span>
              </div>
            </div>
          </div>
        </div>
        <div className="filter-container">
          <select
            className="form-select"
            value={selectedSort}
            onChange={handleSortChange}
            aria-label="Sort by price"
          >
            <option value="default">Mặc định</option>
            <option value="asc">Giá tăng dần</option>
            <option value="desc">Giá giảm dần</option>
          </select>
        </div>
      </div>
      {
        isLoading === false ? (
          currentProducts && currentProducts.length > 0 ? (
            <div className="has-products">
              <div className="category-list-products">
                {
                  currentProducts.map((product, index) => (
                    <React.Fragment key={index}>
                      <ProductItem product={product} />
                      {(index + 1) % 4 === 0 && (index + 1) !== currentProducts.length && (  // Vẽ kẻ ngang
                        <hr className="hr-separate" />
                      )}
                    </React.Fragment>
                  ))
                }
              </div>
              {/* Phần phân trang */}
              <div className="pagination-container">
                <Pagination>
                  <Pagination.Prev onClick={handlePrevious} disabled={activePage === 1} />
                  {[...Array(totalPages)].map((_, number) => ( // Array chạy từ 0
                    <Pagination.Item
                      key={number + 1}
                      active={number + 1 === activePage}
                      onClick={() => handlePageChange(number + 1)}
                    >
                      {number + 1}
                    </Pagination.Item>
                  ))}
                  <Pagination.Next onClick={handleNext} disabled={activePage === totalPages} />
                </Pagination>
              </div>
            </div>
          ) : (
            <div className="no-product">Không có sản phẩm nào</div>
          )
        ) : (
          <div className="loading-container">
            <MoonLoader size={50} color={"#ff0000"} loading={isLoading} />
            <span>
              Đang lấy dữ liệu
            </span>
          </div>
        )
      }
    </div>
  );
}
