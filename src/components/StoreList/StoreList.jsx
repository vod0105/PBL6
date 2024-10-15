// Scroll danh sách cửa hàng có sản phẩm trong page Product Detail

import React from 'react';
import './StoreList.scss'; // Nhớ import CSS nếu cần

const StoreList = ({ stores }) => {
  return (
    <div className="infor-right-store-display">
      {stores && stores.length > 0 ? (
        stores.map((store, index) => (
          <div key={index} className="store-item">
            <img src={'data:image/png;base64,' + store.image} alt={store.storeName} className="store-image" />
            <div className="store-info">
              <span className="store-name">{store.storeName}</span>
              <p className="store-address"><i className="fa-solid fa-location-dot"></i>{store.location}</p>
            </div>
          </div>
        )))
        : (
          <>
            <div>Không có cửa hàng mô có</div>
          </>
        )
      }
    </div>
  );
};

export default StoreList;
