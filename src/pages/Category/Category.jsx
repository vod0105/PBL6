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

  useEffect(() => {
    window.scrollTo(0, 0);
    dispatch(fetchProductsByIdCategory(id));
  }, [id]); // 'id' category thay đổi -> lấy lại list products

  // Lấy sản phẩm cho trang hiện tại
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
    <div
      className={`page-category ${listProducts && listProducts.length > 0 ? 'has-products' : ''}`}
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
  );
}
