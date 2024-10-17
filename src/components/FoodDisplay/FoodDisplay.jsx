import React from "react";
import './FoodDisplay.scss'
import FoodItem from '../FoodItem/FoodItem'

const FoodDisplay = ({ listProducts }) => {
  return (
    <div className='food-display' id='food-display'>
      <div className="food-display-list">
        {
          listProducts && listProducts.length > 0 ? (
            listProducts.map((product, index) => {
              return <FoodItem key={index} product={product} />
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
