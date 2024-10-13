import React from "react";
import './Category.scss'
import styled from "styled-components";
import product1 from "../../assets/food-yummy/product1.jpg";
import product2 from "../../assets/food-yummy/product2.jpg";
import product3 from "../../assets/food-yummy/product3.jpg";
import product4 from "../../assets/food-yummy/product4.jpg";
import ProductItem from "../../components/ProductItem/ProductItem";
// import { imageZoomEffect, TitleStyles } from "./ReusableStyles";
export default function Category() {
  const data = [
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
    },
    {
      id: 5,
      image: product1,
      name: "Combo thơm phức",
      price: "10000",
    },
    {
      id: 6,
      image: product2,
      name: "Gà sốt cay",
      price: "20000",
    },
    {
      id: 7,
      image: product3,
      name: "Burger",
      price: "30000",
    },

    {
      id: 8,
      image: product4,
      name: "Tropical Sundae",
      price: "40000",
    },
    {
      id: 9,
      image: product1,
      name: "Combo thơm phức",
      price: "10000",
    },
    {
      id: 10,
      image: product2,
      name: "Gà sốt cay",
      price: "20000",
    },
  ];
  return (
    <div className="page-category">
      <div className="category-list-products">
        {data.map((product, index) => {
          return (
            <>
              <ProductItem product={product} key={index} />
              {
                (index + 1) % 4 === 0 && (index + 1) !== +data.length && <hr className="hr-separate" />
              }
            </>
          );
        })}
      </div>
    </div>
  );
}
