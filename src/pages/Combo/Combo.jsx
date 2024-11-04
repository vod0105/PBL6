import React, { useState, useEffect } from "react";
import './Combo.scss';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { fetchAllCombos } from "../../redux/actions/productActions";
import Pagination from 'react-bootstrap/Pagination';
import ComboItem from "../../components/ComboItem/ComboItem";

export default function Combo() {
  const dispatch = useDispatch();
  const allCombos = useSelector((state) => state.product.allCombos);

  // State -> rang hiện tại
  const [activePage, setActivePage] = useState(1);
  const itemsPerPage = 8; // Số sản phẩm mỗi trang
  const totalPages = Math.ceil(allCombos.length / itemsPerPage); // Tổng số trang
  // State cho tìm kiếm và sắp xếp
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedSort, setSelectedSort] = useState("default");
  useEffect(() => {
    window.scrollTo(0, 0);
    dispatch(fetchAllCombos());
  }, [dispatch]);

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
  const filteredProducts = allCombos
    .filter((combo) => combo.comboName.toLowerCase().includes(searchTerm.toLowerCase()))
    .sort((a, b) => {
      if (selectedSort === "asc") return a.price - b.price;
      if (selectedSort === "desc") return b.price - a.price;
      return 0; // Mặc định
    });

  // Lấy sản phẩm cho trang hiện tại
  const currentCombos = filteredProducts.slice(
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
        className={`${allCombos && allCombos.length > 0 ? 'has-products' : ''}`}
      >
        <div className="category-list-products">
          {
            currentCombos && currentCombos.length > 0 ? (
              currentCombos.map((combo, index) => (
                <React.Fragment key={index}>
                  <ComboItem combo={combo} />
                  {
                    (index + 1) % 4 === 0 && (index + 1) !== currentCombos.length && <hr className="hr-separate" />
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
