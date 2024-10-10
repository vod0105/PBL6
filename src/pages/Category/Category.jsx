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
      image: product1,
      name: "Combo thơm phức",
      price: "10000",
    },
    {
      image: product2,
      name: "Gà sốt cay",
      price: "20000",
    },
    {
      image: product3,
      name: "Burger",
      price: "30000",
    },

    {
      image: product4,
      name: "Tropical Sundae",
      price: "40000",
    },
    {
      image: product1,
      name: "Combo thơm phức",
      price: "10000",
    },
    {
      image: product2,
      name: "Gà sốt cay",
      price: "20000",
    },
    {
      image: product3,
      name: "Burger",
      price: "30000",
    },

    {
      image: product4,
      name: "Tropical Sundae",
      price: "40000",
    },
    {
      image: product1,
      name: "Combo thơm phức",
      price: "10000",
    },
    {
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

// const Section = styled.section`
//   {TitleStyles};
//   .products {
//     display: grid;
//     grid-template-columns: repeat(4, 1fr);
//     gap: 3rem;
//     margin-top: 3rem;
//     .product {
//       display: flex;
//       flex-direction: column;
//       gap: 0.6rem;
//       justify-content: center;
//       align-items: center;
//       h3 {
//         color: #fc4958;
//       }
//       p {
//         text-align: center;
//         font-size: 1rem;
//         line-height: 2rem;
//         letter-spacing: 0.1rem;
//       }
//       {imageZoomEffect};
//       .image {
//         max-height: 20rem;
//         overflow: hidden;
//         border-radius: 1rem;
//         img {
//           height: 20rem;
//           width: 15rem;
//           object-fit: cover;
//         }
//       }
//       button {
//         border: none;
//         padding: 1rem 4rem;
//         font-size: 1.4rem;
//         color: white;
//         border-radius: 4rem;
//         transition: 0.5s ease-in-out;
//         cursor: pointer;
//         background: linear-gradient(to right, #fc4958, #e85d04);
//         text-transform: uppercase;
//         &:hover {
//           background: linear-gradient(to right, #e85d04, #fc4958);
//         }
//       }
//     }
//   }

//   @media screen and (min-width: 280px) and (max-width: 720px) {
//     .products {
//       grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
//     }
//   }
//   @media screen and (min-width: 720px) and (max-width: 1080px) {
//     .products {
//       grid-template-columns: repeat(2, 1fr);
//     }
//   }
// `;
