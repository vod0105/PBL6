import React, { useRef } from 'react'
import './Store.scss'
import { Container, Row, Col } from "react-bootstrap";
import { Link } from "react-router-dom";

import store7 from "../../assets/image_gg/introduce_7.png";
import store8 from "../../assets/image_gg/introduce_8.png";
import store9 from "../../assets/image_gg/introduce_9.png";
import store10 from "../../assets/image_gg/introduce_10.png";
import store11 from "../../assets/image_gg/introduce_11.png";
import store12 from "../../assets/image_gg/introduce_12.png";


import zigzag from "../../assets/svg/zigzag.png";
import heart from "../../assets/svg/heart.png";

const Store = () => {
  // Section 3: Code4Education
  const contentRef = useRef(null); // Tạo ref để tham chiếu đến nội dung

  const scrollToContent = () => {
    if (contentRef.current) {
      contentRef.current.scrollIntoView({ behavior: 'smooth' }); // Cuộn đến nội dung
    }
  };
  const stores = [
    {
      id: 7,
      image: store7,
      name: 'JBVN065 - Trường Chinh',
      address: '360 Truong Chinh st, ward 13, Dis Tan Binh, HCM City',
      phonenumber: '(028) 3812-5053 / (028) 3812-5063',
      time: '8:30 AM - 9:15 PM (Thứ 2 - Chủ Nhật)'
    },
    {
      id: 8,
      image: store8,
      name: 'JBVN115 - EC Âu Cơ',
      address: '650 Au cơ, Ward 10, Tan Binh Distric, HCMC',
      phonenumber: '(028) 3861-6848',
      time: ' 8:30 AM - 9:00 PM (Thứ 2 - Chủ Nhật)'
    },
    {
      id: 9,
      image: store9,
      name: 'JBVN018 - Vincom Cộng Hòa',
      address: 'Ground Flr. Maximark Cong Hoa, 15-17 Cong Hoa, Tan Binh Dist. HCMC',
      phonenumber: ' (028) 3811-7000 / (028) 3811-5039',
      time: '7:30 AM - 10:30 PM (Thứ 2 - Chủ Nhật)'
    },
    {
      id: 10,
      image: store10,
      name: 'JBVN184 - EC Tân Hương',
      address: '131 Tân Hương, Tân Quý Ward, Tân Phú District, HCM City',
      phonenumber: ' 02822066027',
      time: '9:30 AM - 9:00 PM (Thứ 2 - Chủ Nhật)'
    }
  ];
  return (
    <section className="page-store">
      <Row>
        {/* Image */}
        <div className='header'>
          <div className="header-circle">
            <div className="header-title">
              CỬA HÀNG
            </div>
            <div className="header-deco">
              <img className='icon-zigzak' src={zigzag} alt="" />
              <img className='icon-heart' src={heart} alt="" />
              <img src={zigzag} alt="" />
            </div>
            <div className="header-content">
              TẬN HƯỞNG NHỮNG KHOẢNH KHẮC TRỌN VẸN CÙNG FOS
            </div>
            <div className="header-arrow-down" onClick={scrollToContent}>
              <i className="fa-solid fa-angles-down arrow-animation"></i>
            </div>
          </div>
        </div>
      </Row>
      <div ref={contentRef} className="list-stores">
        {
          stores ? <>
            {stores.map((store, index) => (
              <div key={index} className="store">
                <div
                  className="store-image"
                  style={{ background: `url(${store.image}) no-repeat center center`, backgroundSize: 'cover' }}>
                </div>
                <div className="store-content">
                  <div className="store-name">
                    {store.name}
                  </div>
                  <div className="store-address">
                    <span><i className="fa-solid fa-location-dot"></i>{store.address}</span>
                  </div>
                  <div className="store-btn-viewdetail">
                    <Link to={`/test-store-detail/${store.id}`}>
                      <button>Xem chi tiết</button>
                    </Link>
                  </div>
                </div>
              </div>
            ))}

          </>
            :
            <div>Không có chi cả</div>
        }
      </div>
    </section>
  )
}

export default Store
