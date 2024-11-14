import React from 'react';
import './Download.scss'
import { NavLink } from 'react-router-dom';

const Download = () => {
    return (
        <div className="page-download">
            <div className="container">
                <div className="paragraph-complete">
                    <p>Tải ngay ứng dụng của chúng tôi trên </p>
                    <NavLink
                        to="/"
                        end
                    >
                        <button>Về trang chủ</button>
                    </NavLink>
                </div>

            </div>
        </div>
    )
}

export default Download;