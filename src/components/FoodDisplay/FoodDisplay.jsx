import React, { useState } from "react";
import './FoodDisplay.scss';
import FoodItem from '../FoodItem/FoodItem';
import Pagination from 'react-bootstrap/Pagination';

const FoodDisplay = ({ listProducts, itemsPerPage = 8 }) => {
  const [activePage, setActivePage] = useState(1);

  // Tính toán số trang dựa trên danh sách sản phẩm và số sản phẩm mỗi trang
  const totalPages = Math.ceil(listProducts.length / itemsPerPage);

  // Lấy danh sách sản phẩm cho trang hiện tại
  const currentProducts = listProducts.slice(
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
    <div className='food-display' id='food-display'>
      <div className="food-display-list">
        {
          currentProducts && currentProducts.length > 0 ? (
            currentProducts.map((product, index) => (
              <FoodItem key={index} product={product} />
            ))
          ) : (
            <div className="no-product">Không có sản phẩm</div>
          )
        }
      </div>

      {/* Phần phân trang */}
      <div className="pagination-container">
        <Pagination className="food-display-pagination">
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
  );
};

export default FoodDisplay;
