// Scroll danh sách cửa hàng có sản phẩm trong page Product Detail

import React from 'react';
import './StoreList.scss'; // Nhớ import CSS nếu cần

const StoreList = ({ stores }) => {
  return (
    <div className="infor-right-store-display">
      {stores.map((store, index) => (
        <div key={index} className="store-item">
          <img src={store.image} alt={store.name} className="store-image" />
          <div className="store-info">
            <h5 className="store-name">{store.name}</h5>
            <p className="store-address">{store.address}</p>
          </div>
        </div>
      ))}
    </div>
  );
};

export default StoreList;
