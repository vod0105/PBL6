import React, { useState, useEffect } from "react";
import './ExploreMenu.scss'
import { useDispatch, useSelector } from 'react-redux';
import { fetchAllCategories } from "../../redux/actions/categoryActions";
import { NavLink } from "react-router-dom";

const ExploreMenu = () => {
  // fetch category
  const listCategories = useSelector((state) => {
    return state.category.listCategories;
  })
  return (
    <div className='explore-menu' id='explore-menu'>
      <h1>Ăn gì hôm nay</h1>
      <p className='explore-menu-text'>Thực đơn đa dạng và phong phú, có rất nhiều sự lựa chọn cho bạn, gia đình và bạn bè.</p>
      <div className="explore-menu-list">
        {listCategories && listCategories.length > 0
          &&
          listCategories.map((category, index) => {
            return (
              <NavLink to={`/category/${category.categoryId}`} key={index}>
                <div key={index} className='explore-menu-list-item'>
                  <img className='active' src={'data:image/png;base64,' + category.image} alt="alt-category" />
                  <p>{category.categoryName}</p>
                </div>
              </NavLink>
            )
          })}
      </div>
      <hr />
    </div>
  )
}
export default ExploreMenu
