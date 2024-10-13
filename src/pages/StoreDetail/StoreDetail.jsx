import React, { useState } from 'react'
import './StoreDetail.scss'
import test_product from "../../assets/food-yummy/product1.jpg";
import { assets } from '../../assets/assets'

import DownloadImage from "../../assets/shop/ggmap.jpg";
import FoodDisplay from '../../components/FoodDisplay/FoodDisplay';
import store7 from "../../assets/image_gg/introduce_7.png";
import store8 from "../../assets/image_gg/introduce_8.png";
import store9 from "../../assets/image_gg/introduce_9.png";
import store10 from "../../assets/image_gg/introduce_10.png";

import { useParams } from 'react-router-dom';
const StoreDetail = () => {
  const { id } = useParams(); // Lấy giá trị từ URL
  const [category, setCategory] = useState("All")
  const stores = [
    {
      id: 7,
      image: store7,
      name: 'JBVN065 - Trường Chinh',
      address: '360 Truong Chinh st, ward 13, Dis Tan Binh, HCM City',
      phonenumber: '(028) 3812-5053 / (028) 3812-5063',
      time: '8:30 AM - 9:15 PM (Thứ 2 - Chủ Nhật)'
    },
    {
      id: 8,
      image: store8,
      name: 'JBVN115 - EC Âu Cơ',
      address: '650 Au cơ, Ward 10, Tan Binh Distric, HCMC',
      phonenumber: '(028) 3861-6848',
      time: ' 8:30 AM - 9:00 PM (Thứ 2 - Chủ Nhật)'
    },
    {
      id: 9,
      image: store9,
      name: 'JBVN018 - Vincom Cộng Hòa',
      address: 'Ground Flr. Maximark Cong Hoa, 15-17 Cong Hoa, Tan Binh Dist. HCMC',
      phonenumber: ' (028) 3811-7000 / (028) 3811-5039',
      time: '7:30 AM - 10:30 PM (Thứ 2 - Chủ Nhật)'
    },
    {
      id: 10,
      image: store10,
      name: 'JBVN184 - EC Tân Hương',
      address: '131 Tân Hương, Tân Quý Ward, Tân Phú District, HCM City',
      phonenumber: ' 02822066027',
      time: '9:30 AM - 9:00 PM (Thứ 2 - Chủ Nhật)'
    }
  ];
  // find store
  const store = stores.find(store => store.id === +id);

  if (!store) {
    return <div>Không có thông tin cửa hàng.</div>;
  }
  else return (
    <div className="page-store-detail">
      <div className="container">
        <div className="store-detail-infor">
          <div className="infor-left">
            <div className="infor-left-img-container">
              <img src={store.image} alt="" />
            </div>
            <div className="infor-left-infor-container">
              <div className="infor-left-name">{store.name}</div>
              <div className="infor-left-contact-container">
                <span className="contact-location">
                  <i class="fa-solid fa-compass"></i>
                  {store.address}
                </span>
                <span className="contact-phone">
                  <i class="fa-solid fa-phone"></i>
                  {store.phonenumber}
                </span>
                <span className="contact-time">
                  <i class="fa-solid fa-clock"></i>
                  {store.time}
                </span>
              </div>
            </div>
          </div>
          <div className="infor-right">
            <div className="infor-right-img-container">
              <img src={DownloadImage} alt="" />
            </div>
          </div>
          {/* <ProductItemModal
            showModalProduct={showModalProduct}
            handleCloseModalProduct={handleCloseModalProduct}
            // product={stores}
            // stores={stores}
          /> */}
        </div>
        <div className="list-products">
          {/* <h2>SẢN PHẨM HIỆN CÓ</h2> */}
          <FoodDisplay category={category} />
        </div>
      </div>
    </div>
  )
}

export default StoreDetail
