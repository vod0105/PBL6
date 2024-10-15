import React, { useState, useEffect } from "react";
import './Home.scss'
import Header from '../../components/Header/Header'
import ExploreMenu from '../../components/ExploreMenu/ExploreMenu'
import FoodDisplay from '../../components/FoodDisplay/FoodDisplay'
import AppDownload from '../../components/AppDownLoad/AppDownload'
import Service from '../../components/Service/Service'
import BannerWelcome from '../../components/BannerWelcome/BannerWelcome'

import { useDispatch, useSelector } from 'react-redux';
import { fetchProductsBestSale } from "../../redux/actions/productActions";

const Home = () => {
  // fetch product best sale
  const dispatch = useDispatch();
  const listProductsBestSale = useSelector((state) => {
    return state.product.listProductsBestSale;
  })

  useEffect(() => {
    dispatch(fetchProductsBestSale());
  }, []);

  return (
    <div className='page-homepage'>
      <Header />
      <ExploreMenu />
      <BannerWelcome />
      <Service />
      <h2>SẢN PHẨM BÁN CHẠY</h2>
      <FoodDisplay listProducts={listProductsBestSale} />
      <AppDownload />
    </div>
  )
}

export default Home
