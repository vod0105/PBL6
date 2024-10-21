import React, { useState, useEffect, useRef } from 'react'
import './Promotion.scss'
import { Container, Row, Col } from "react-bootstrap";
import { Link } from "react-router-dom";
import line from "../../assets/svg/marker.png";
import promotionIcon from "../../assets/svg/promotion.png";
import { useDispatch, useSelector } from 'react-redux';
import { fetchAllPromotions } from '../../redux/actions/promotionActions';


import promo1 from '../../assets/promotion/promotion_1.png'
import promo2 from '../../assets/promotion/promotion_2.png'
import promo3 from '../../assets/promotion/promotion_3.png'
import promo4 from '../../assets/promotion/promotion_4.png'
import promo5 from '../../assets/promotion/promotion_5.png'

const Promotion = () => {
  // fetch all promotions
  const dispatch = useDispatch();
  const promotions = useSelector((state) => {
    return state.promotion.listPromotions;
  })
  useEffect(() => {
    dispatch(fetchAllPromotions());
  }, []);
  // Lướt trang
  const contentRef = useRef(null);
  const scrollToContent = () => {
    if (contentRef.current) {
      contentRef.current.scrollIntoView({ behavior: 'smooth' }); // Cuộn đến nội dung
    }
  };
  useEffect(() => {
    return () => {
      contentRef.current = null;
    };
  }, []);

  return (
    <section className="page-promotion">
      <Row>
        {/* Image */}
        <div className='header'>
          <div className="header-circle">
            <div className="header-title">
              KHUYẾN MÃI
            </div>
            <div className="header-deco">
              <img className='icon-zigzak' src={line} alt="" />
              <img className='icon-promotion' src={promotionIcon} alt="" />
              <img src={line} alt="" />
            </div>
            <div className="header-content">
              NHẬN NHIỀU ƯU ĐÃI ĐẶC BIỆT CÙNG FOS
            </div>
            <div className="header-arrow-down" onClick={scrollToContent}>
              <i className="fa-solid fa-angles-down arrow-animation"></i>
            </div>
          </div>
        </div>
      </Row>
      <div className="container mt-3" ref={contentRef}>
        <div className="promotions-container">
          <div className="promotions-grid">
            {
              promotions ? (promotions.map((promo, index) => (
                <Link to={`/promotion-detail/${promo.id}`}>
                  <div className="promo-card" key={index}>
                    <img src={'data:image/png;base64,' + promo.image} alt='Khuyến mãi' />
                    <div className="promo-content">
                      <h3>{promo.name}</h3>
                      <p>{promo.description}</p>
                    </div>
                  </div>
                </Link>
              )))
                : (
                  <div>KHÔNG CÓ CHƯƠNG TRÌNH KHUYẾN MÃI</div>
                )
            }
          </div>
        </div>
      </div>
    </section>
  )
}

export default Promotion
