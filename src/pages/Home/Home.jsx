import React, { useState, useEffect } from "react";
import './Home.scss'
import Header from '../../components/Header/Header'
import ExploreMenu from '../../components/ExploreMenu/ExploreMenu'
import FoodDisplay from '../../components/FoodDisplay/FoodDisplay'
import Service from '../../components/Service/Service'
import BannerWelcome from '../../components/BannerWelcome/BannerWelcome'

import { useDispatch, useSelector } from 'react-redux';
import { fetchProductsBestSale } from "../../redux/actions/productActions";
import { fetchFavouriteProducs } from "../../redux/actions/userActions";

const Home = () => {
  // fetch product best sale
  const dispatch = useDispatch();
  const listProductsBestSale = useSelector((state) => {
    return state.product.listProductsBestSale;
  })
  const isLoadingListProductsBestSale = useSelector((state) => {
    return state.product.isLoadingListProductsBestSale;
  })
  const isLoadingListFavouriteProducts = useSelector((state) => {
    return state.user.isLoadingListFavouriteProducts;
  })

  const isAuthenticated = useSelector((state) => {
    return state.auth.isAuthenticated;
  })
  const account = useSelector((state) => {
    return state.auth.account;
  })
  const listFavouriteProducts = useSelector((state) => {
    // console.log("Favourite Products:", state.user.listFavouriteProducts);
    return state.user.listFavouriteProducts;
  })

  // useEffect(() => {
  //   dispatch(fetchProductsBestSale());
  // }, []);
  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);
  
  useEffect(() => {
    if (account) {
      dispatch(fetchFavouriteProducs(account.id));
    }
  }, [account, dispatch]);

  // Image -> base64
  const convertToBase64 = (file) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onloadend = () => {
        const base64String = reader.result.split(',')[1]; // Xóa phần "data:image/png;base64,"
        resolve(base64String);
      };
      reader.onerror = (error) => {
        reject(error);
      };
      reader.readAsDataURL(file);
    });
  };

  const handleFileChange = async (event) => {
    const file = event.target.files[0];

    try {
      const base64 = await convertToBase64(file);
      console.log(base64);
    } catch (error) {
      console.error("Lỗi khi chuyển đổi ảnh: ", error);
    }
  };

  return (
    <div className='page-homepage'>
      {/* <input type="file" accept="image/*" onChange={handleFileChange} /> */}
      <Header />
      <ExploreMenu />
      <BannerWelcome />
      <Service />
      <h2>SẢN PHẨM BÁN CHẠY</h2>
      <FoodDisplay listProducts={listProductsBestSale} isLoading={isLoadingListProductsBestSale} />
      {
        isAuthenticated && (
          <>
            <h2>CÓ THỂ BẠN QUAN TÂM</h2>
            {
              listFavouriteProducts && (
                <FoodDisplay listProducts={listFavouriteProducts} isLoading={isLoadingListFavouriteProducts} />
              )
            }
          </>
        )
      }

    </div>
  )
}

export default Home
