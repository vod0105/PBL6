import React, { useState, useEffect } from 'react'
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
import { useDispatch, useSelector } from 'react-redux';
import { fetchStoreById } from "../../redux/actions/storeActions";
import { fetchProductsByIdStore } from '../../redux/actions/productActions';

const StoreDetail = () => {
  const { id } = useParams();
  const dispatch = useDispatch();
  const storeDetail = useSelector((state) => {
    return state.store.storeDetail;
  })
  const listProductsByIdStore = useSelector((state) => {
    return state.product.listProductsByIdStore;
  })

  useEffect(() => {
    window.scrollTo(0, 0);
    dispatch(fetchStoreById(id));
    dispatch(fetchProductsByIdStore(id));
  }, [id]);

  if (!storeDetail) {
    return <div>Không có thông tin cửa hàng.</div>;
  }
  else return (
    <div className="page-store-detail">
      <div className="container">
        <div className="store-detail-infor">
          <div className="infor-left">
            <div className="infor-left-img-container">
              <img src={'data:image/png;base64,' + storeDetail.image} alt="" />
            </div>
            <div className="infor-left-infor-container">
              <div className="infor-left-name">{storeDetail.storeName}</div>
              <div className="infor-left-contact-container">
                <span className="contact-location">
                  <i class="fa-solid fa-compass"></i>
                  {storeDetail.location}
                </span>
                <span className="contact-phone">
                  <i class="fa-solid fa-phone"></i>
                  {storeDetail.numberPhone}
                </span>
                <span className="contact-time">
                  <i class="fa-solid fa-clock"></i>
                  {storeDetail.openingTime} - {storeDetail.closingTime}
                </span>
              </div>
            </div>
          </div>
          <div className="infor-right">
            <div className="infor-right-img-container">
              <img src={DownloadImage} alt="" />
            </div>
          </div>
        </div>
        <div className="list-products">
          <FoodDisplay listProducts={listProductsByIdStore} />
        </div>
      </div>
    </div>
  )
}

export default StoreDetail
