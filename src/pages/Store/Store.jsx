import React from 'react'
import './Store.scss'
import { Container, Row, Col } from "react-bootstrap";
import { Link } from "react-router-dom";

import store1 from "../../assets/image_gg/introduce_1.png";
import store2 from "../../assets/image_gg/introduce_2.png";

const Store = () => {
  // Section 3: Code4Education
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
              --- KSJDFDS ---
            </div>
            <div className="header-content">
              Chúng tôi có quá nhiều cửa hàng phải canh
            </div>
            <div className="header-arrow-down">
              <i class="fa-solid fa-angles-down"></i>
            </div>
          </div>
        </div>
      </Row>
      <Row className='mt-3 mx-5'>
        <Col sm={6} lg={6} >
          <div className="ads_box ads_img1 mb-5 mb-md-0">
            <h4 className="mb-0">DEAL CỰC ĐÃ</h4>
            <h5>- ĂN THẢ GA</h5>
            <Link to="/" className="btn btn_red px-4 rounded-0">
              Xem chi tiết
            </Link>
          </div>
        </Col>
        <Col sm={6} lg={6}>
          <div className="ads_box ads_img2">
            <h4 className="mb-0">BỮA TRƯA TRÒN VỊ</h4>
            <h5>- GIÁ HỢP LÝ</h5>
            <Link to="/" className="btn btn_red px-4 rounded-0">
              Xem chi tiết
            </Link>
          </div>
        </Col>
      </Row>

      <Row className='mt-3 mx-5'>
        <Col sm={6} lg={6} >
          <div className="ads_box ads_img1 mb-5 mb-md-0">
            <h4 className="mb-0">DEAL CỰC ĐÃ</h4>
            <h5>- ĂN THẢ GA</h5>
            <Link to="/" className="btn btn_red px-4 rounded-0">
              Xem chi tiết
            </Link>
          </div>
        </Col>
        <Col sm={6} lg={6}>
          <div className="ads_box ads_img2">
            <h4 className="mb-0">BỮA TRƯA TRÒN VỊ</h4>
            <h5>- GIÁ HỢP LÝ</h5>
            <Link to="/" className="btn btn_red px-4 rounded-0">
              Xem chi tiết
            </Link>
          </div>
        </Col>
      </Row>
    </section>
  )
}

export default Store
