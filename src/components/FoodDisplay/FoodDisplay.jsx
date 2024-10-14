// Sản phẩm bán chạy

import React, { useState, useEffect } from "react";
import './FoodDisplay.scss'
import FoodItem from '../FoodItem/FoodItem'
import top_1 from '../../assets/1.png'
import top_2 from '../../assets/2.png'
import top_3 from '../../assets/3.png'
import top_4 from '../../assets/4.png'
import product1 from "../../assets/food-yummy/product1.jpg";
import product2 from "../../assets/food-yummy/product2.jpg";
import product3 from "../../assets/food-yummy/product3.jpg";
import product4 from "../../assets/food-yummy/product4.jpg";

import { useDispatch, useSelector } from 'react-redux';
import { fetchProductsBestSale } from "../../redux/actions/productActions";


const FoodDisplay = () => {
  // fetch product best sale
  const dispatch = useDispatch();
  const listProductsBestSale = useSelector((state) => {
    return state.product.listProductsBestSale;
  })

  useEffect(() => {
    dispatch(fetchProductsBestSale());
  }, []);

  return (
    <div className='food-display' id='food-display'>
      <div className="food-display-list">
        {listProductsBestSale.map((product, index) => {
          // if (category === "All" || category === item.category) {
          return <FoodItem key={index} product={product} />
          // }
        })}
      </div>
    </div>
  )
}

export default FoodDisplay
