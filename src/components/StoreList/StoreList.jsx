// Scroll danh sách cửa hàng có sản phẩm trong page Product Detail
import React from 'react';
import './StoreList.scss';

const StoreList = ({ stores, onSelectStore, selectedStore }) => {
  return (
    <div className="infor-right-store-display">
      {stores && stores.length > 0 ? (
        stores.map((store, index) => (
          <div
            key={index}
            className={`store-item ${selectedStore && selectedStore.storeName === store.storeName ? 'selected-store-item' : ''}`}
            onClick={() => onSelectStore(store)}
          >
            <img src={'data:image/png;base64,' + store.image} alt={store.storeName} className="store-image" />
            <div className="store-info">
              <span className="store-name">{store.storeName}</span>
              <p className="store-address"><i className="fa-solid fa-location-dot"></i>{store.location}</p>
            </div>
          </div>
        ))
      ) : (
        <div>Không có cửa hàng</div>
      )}
    </div>
  );
};

export default StoreList;