import React, { useContext } from 'react'
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

const FoodDisplay = ({ category }) => {

  const products = [
    {
      id: 1,
      image: product1,
      name: "Combo thơm phức",
      price: "10000",
    },
    {
      id: 2,
      image: product2,
      name: "Gà sốt cay",
      price: "20000",
    },
    {
      id: 3,
      image: product3,
      name: "Burger",
      price: "30000",
    },

    {
      id: 4,
      image: product4,
      name: "Tropical Sundae",
      price: "40000",
    }
  ];

  return (
    <div className='food-display' id='food-display'>
      <div className="food-display-list">
        {products.map((product, index) => {
          // if (category === "All" || category === item.category) {
          return <FoodItem key={index} product={product} />
          // }
        })}
      </div>
    </div>
  )
}

export default FoodDisplay
