import React, { useState, useEffect } from "react";
import './Category.scss';
import ProductItem from "../../components/ProductItem/ProductItem";
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { fetchProductsByIdCategory } from "../../redux/actions/productActions";
import Pagination from 'react-bootstrap/Pagination';

export default function Category() {
  const { id } = useParams();
  const dispatch = useDispatch();
  const listProducts = useSelector((state) => state.product.listProductsByIdCategory);

  // State -> rang hiện tại
  const [activePage, setActivePage] = useState(1);
  const itemsPerPage = 8; // Số sản phẩm mỗi trang
  const totalPages = Math.ceil(listProducts.length / itemsPerPage); // Tổng số trang
  // State cho tìm kiếm và sắp xếp
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedSort, setSelectedSort] = useState("default");
  useEffect(() => {
    window.scrollTo(0, 0);
    dispatch(fetchProductsByIdCategory(id));
  }, [id, dispatch]); // 'id' category thay đổi -> lấy lại list products

  // Hàm xử lý thay đổi từ khóa tìm kiếm
  const handleSearchChange = (event) => {
    setSearchTerm(event.target.value);
    setActivePage(1); // Reset về trang 1 khi tìm kiếm mới
  };

  // Hàm xử lý thay đổi sắp xếp
  const handleSortChange = (event) => {
    setSelectedSort(event.target.value);
    setActivePage(1); // Reset về trang 1 khi thay đổi sắp xếp
  };

  // Lọc và sắp xếp sản phẩm theo từ khóa và giá
  const filteredProducts = listProducts
    .filter((product) => product.productName.toLowerCase().includes(searchTerm.toLowerCase()))
    .sort((a, b) => {
      if (selectedSort === "asc") return a.discountedPrice - b.discountedPrice;
      if (selectedSort === "desc") return b.discountedPrice - a.discountedPrice;
      return 0; // Mặc định
    });

  // Lấy sản phẩm cho trang hiện tại
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

  return (
    <div className="page-category">
      <div className="search-filter-container">
        <div className="search-container">
          <div className="row">
            <div className="col-md-12">
              <div className="input-group">
                <input
                  className="form-control border-end-0 border"
                  type="search"
                  value={searchTerm}
                  onChange={handleSearchChange}
                  placeholder="Tìm kiếm sản phẩm"
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
      <div
        className={`${listProducts && listProducts.length > 0 ? 'has-products' : ''}`}
      >
        <div className="category-list-products">
          {
            currentProducts && currentProducts.length > 0 ? (
              currentProducts.map((product, index) => (
                <React.Fragment key={index}>
                  <ProductItem product={product} />
                  {
                    (index + 1) % 4 === 0 && (index + 1) !== currentProducts.length && <hr className="hr-separate" />
                  }
                </React.Fragment>
              ))
            ) : (
              <div className="no-product">Không có sản phẩm</div>
            )
          }
        </div>

        {/* Phần phân trang */}
        <div className="pagination-container">
          <Pagination>
            <Pagination.Prev onClick={handlePrevious} disabled={activePage === 1} />
            {[...Array(totalPages)].map((_, number) => (
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
    </div>
  );
}
