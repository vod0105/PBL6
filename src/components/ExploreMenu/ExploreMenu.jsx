import React, { useState, useEffect } from "react";
import './ExploreMenu.scss'
import { menu_list } from '../../assets/assets'

import { useDispatch, useSelector } from 'react-redux';
import { showLoginModal, showRegisterModal } from "../../redux/actions/modalActions";
import { fetchAllCategories } from "../../redux/actions/categoryActions";

const ExploreMenu = ({ category, setCategory }) => {
  // fetch category
  const dispatch = useDispatch();
  const listCategories = useSelector((state) => {
    return state.category.listCategories;
  })
  const isLoading = useSelector(state => state.category.isLoading);
  const isError = useSelector(state => state.category.isError);
  // useEffect(() => {
  //   // dispatch(fetchAllCategories());
  // }, [listCategories])
  return (
    <div className='explore-menu' id='explore-menu'>
      <h1>Ăn gì hôm nay</h1>
      <p className='explore-menu-text'>Thực đơn đa dạng và phong phú, có rất nhiều sự lựa chọn cho bạn, gia đình và bạn bè.</p>
      <div className="explore-menu-list">
        {listCategories && listCategories.length > 0
          &&
          listCategories.map((category, index) => {
            return (
              <div key={index} className='explore-menu-list-item'>
                <img className='active' src={'data:image/png;base64,' + category.image} alt="alt-category" />
                <p>{category.categoryName}</p>
              </div>
            )
          })}
      </div>
      <hr />
    </div>
  )
}

export default ExploreMenu
