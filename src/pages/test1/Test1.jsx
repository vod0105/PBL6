import React, { useState, useEffect } from "react";
import ReactPaginate from "react-paginate";
import axios from "axios";
import "../test1/test1.css";
const PaginationExample = () => {
  const [items, setItems] = useState([]); // Dữ liệu gốc
  const [currentItems, setCurrentItems] = useState([]); // Dữ liệu trên trang hiện tại
  const [pageCount, setPageCount] = useState(0); // Tổng số trang
  const [itemOffset, setItemOffset] = useState(0); // Vị trí bắt đầu của trang hiện tại
  const [loading, setLoading] = useState(true); // Trạng thái loading
  const [error, setError] = useState(null); // Trạng thái lỗi

  const itemsPerPage = 10; // Số mục trên mỗi trang

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const token = localStorage.getItem("access_token");
        const response = await axios.get(
          `http://10.10.2.94:8080/api/v1/public/products/all`
        );
        setItems(response.data.data || []);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    const endOffset = itemOffset + itemsPerPage;
    setCurrentItems(items.slice(itemOffset, endOffset)); // Cắt dữ liệu theo trang
    setPageCount(Math.ceil(items.length / itemsPerPage)); // Tính tổng số trang
  }, [itemOffset, items]);

  const handlePageClick = (event) => {
    const newOffset = (event.selected * itemsPerPage) % items.length;
    setItemOffset(newOffset);
  };

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  return (
    <div>
      <ul>
        {currentItems.map((item, index) => (
          <li key={index}>{item.name || `Item #${index + 1}`}</li>
        ))}
      </ul>
      <ReactPaginate
        breakLabel="..."
        nextLabel="Next >"
        onPageChange={handlePageClick}
        pageRangeDisplayed={5}
        pageCount={pageCount}
        previousLabel="< Previous"
        containerClassName="pagination"
        activeClassName="active"
      />
    </div>
  );
};

export default PaginationExample;
