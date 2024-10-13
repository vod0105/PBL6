import React, { useState } from 'react'
import './Home.scss'
import Header from '../../components/Header/Header'
import ExploreMenu from '../../components/ExploreMenu/ExploreMenu'
import FoodDisplay from '../../components/FoodDisplay/FoodDisplay'
import AppDownload from '../../components/AppDownLoad/AppDownload'
import Service from '../../components/Service/Service'
import BannerWelcome from '../../components/BannerWelcome/BannerWelcome'
const Home = () => {
  const [category, setCategory] = useState("All")

  return (
    <div className='page-homepage'>
      <Header />
      <ExploreMenu category={category} setCategory={setCategory} />
      <BannerWelcome />
      <Service />
      <h2>SẢN PHẨM BÁN CHẠY</h2>
      <FoodDisplay category={category} />
      <AppDownload />
    </div>
  )
}

export default Home
