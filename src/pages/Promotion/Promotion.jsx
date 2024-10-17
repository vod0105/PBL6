import React from 'react'
import './Promotion.scss'
import { Container, Row, Col } from "react-bootstrap";
import { Link } from "react-router-dom";

const Promotion = () => {
  return (
    <section className="page-promotion">
      <Row>
        {/* Image */}
        <div className='header'>
        </div>
      </Row>
      <Row className='mt-3 mx-5'>
        <Col sm={6} lg={6} >
          <div className="ads_box ads_img1">
            <h4 className="mb-0">DEAL CỰC ĐÃ</h4>
            <h5>- ĂN THẢ GA</h5>
            <Link to="/" className="btn btn_red px-4 rounded-0">
              Xem chi tiết
            </Link>
          </div>
        </Col>
        <Col sm={6} lg={6}>
          <div className="ads_box ads_img1">
            <h4 className="mb-0">DEAL CỰC ĐÃ</h4>
            <h5>- ĂN THẢ GA</h5>
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
          <div className="ads_box ads_img1">
            <h4 className="mb-0">DEAL CỰC ĐÃ</h4>
            <h5>- ĂN THẢ GA</h5>
            <Link to="/" className="btn btn_red px-4 rounded-0">
              Xem chi tiết
            </Link>
          </div>
        </Col>
      </Row>
    </section>
  )
}

export default Promotion
