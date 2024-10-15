// Sản phẩm bán chạy

import React from "react";
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


const FoodDisplay = ({ listProducts }) => {
  return (
    <div className='food-display' id='food-display'>
      <div className="food-display-list">
        {
          listProducts && listProducts.length > 0 ? (
            listProducts.map((product, index) => {
              return <FoodItem key={index} product={product} />
              // }
            })
          )
            : (
              <div className="no-product">Không có sản phẩm</div>
            )
        }
      </div>
    </div>
  )
}

export default FoodDisplay
