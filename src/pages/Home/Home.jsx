import React, { useState } from 'react'
import './Home.css'
import Header from '../../components/Header/Header'
import ExploreMenu from '../../components/ExploreMenu/ExploreMenu'
import FoodDisplay from '../../components/FoodDisplay/FoodDisplay'
import AppDownload from '../../components/AppDownLoad/AppDownload'
import Service from '../../components/Service/Service'
import BannerWelcome from '../../components/BannerWelcome/BannerWelcome'
const Home = () => {
  const [category, setCategory] = useState("All")

  return (
    <div>
      <Header />
      <ExploreMenu category={category} setCategory={setCategory} />
      <BannerWelcome />
      <Service />
      <FoodDisplay category={category} />
      <AppDownload />
    </div>
  )
}

export default Home
