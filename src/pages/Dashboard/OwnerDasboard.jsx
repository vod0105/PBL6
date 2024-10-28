import "./OwnerDasboard.css";
import React, { useEffect, useState, useContext } from "react";
import { Line, Bar, Pie } from "react-chartjs-2";

import axios from "axios";
import { StoreContext } from "../../context/StoreContext";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Title,
  Tooltip,
  Legend,
} from "chart.js";
import { assets } from "../../assets/assets";

// Đăng ký các thành phần biểu đồ
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Title,
  Tooltip,
  Legend
);

const OwnerDasboard = () => {
  const { setIsAuthenticated, setUserData, userData, url } =
    useContext(StoreContext);

  const [ordermonth, setordermonth] = useState("");
  const [allbudger, setallbudger] = useState("");
  useEffect(() => {
    const fetchData = async () => {
      try {
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };

        const rsordermonth = await axios.get(
          `${url}/api/v1/admin/display/order/month`,
          { headers }
        );

        setordermonth(rsordermonth.data.data); // Cập nhật state với dữ liệu phản hồi từ API
      } catch (error) {
        console.error("Lỗi khi lấy dữ liệu:", error);
      }
    };

    fetchData();
  }, []);

  //all budget
  useEffect(() => {
    const fetchData2 = async () => {
      try {
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };

        const rs = await axios.get(`${url}/api/v1/admin/display/budget/all`, {
          headers,
        });

        setallbudger(rs.data.data); // Cập nhật state với dữ liệu phản hồi từ API
      } catch (error) {
        console.error("Lỗi khi lấy dữ liệu:", error);
      }
    };

    fetchData2();
  }, []);

  // Dữ liệu cho biểu đồ đường
  const lineData = {
    labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Thán1"],
    datasets: [
      {
        label: "Doanh thu",
        data: [1200, 1900, 3000, 5000, 2400, 3500],
        borderColor: "rgba(75,192,192,1)",
        backgroundColor: "rgba(75,192,192,0.2)",
        fill: true,
      },
    ],
  };

  // Dữ liệu cho biểu đồ cột
  const barData = {
    labels: [
      "Sản phẩm A",
      "Sản phẩm B",
      "Sản phẩm C",
      "Sản phẩm D",
      "Sản phẩm E",
      "Sản phẩm f",
      "Sản phẩm g",
    ],
    datasets: [
      {
        label: "Số lượng bán ra",
        data: [400, 300, 500, 200, 350],
        backgroundColor: [
          "rgba(255,99,132,0.2)",
          "rgba(54,162,235,0.2)",
          "rgba(255,206,86,0.2)",
          "rgba(75,192,192,0.2)",
          "rgba(153,102,255,0.2)",
        ],
        borderColor: [
          "rgba(255,99,132,1)",
          "rgba(54,162,235,1)",
          "rgba(255,206,86,1)",
          "rgba(75,192,192,1)",
          "rgba(153,102,255,1)",
        ],
        borderWidth: 1,
      },
    ],
  };

  // Dữ liệu cho biểu đồ tròn
  const pieData = {
    labels: [
      "Sản phẩm A",
      "Sản phẩm B",
      "Sản phẩm C",
      "Sản phẩm D",
      "Sản phẩm D",
    ],
    datasets: [
      {
        data: [300, 50, 100, 150],
        backgroundColor: [
          "rgba(255,99,132,1)",
          "rgba(54,162,235,1)",
          "rgba(255,206,86,1)",
          "rgba(75,192,192,1)",
        ],
        hoverBackgroundColor: [
          "rgba(255,99,132,1)",
          "rgba(54,162,235,1)",
          "rgba(255,206,86,1)",
          "rgba(75,192,192,1)",
        ],
      },
    ],
  };

  return (
    <div className="dashboard">
      <div className="content-header">
        <div className="list">
          <div className="item">
            <p>Budget Owner</p>
            <div className="coverimg">
              <img
                src={assets.budgett3}
                alt=""
                className="img-item"
                style={{ objectFit: "cover", marginTop: "25px" }}
              />
            </div>
            <h3>{allbudger == null ? 0 : Math.floor(allbudger / 1000000)}</h3>{" "}
            <span>(triệu đồng)</span>
          </div>
          <div className="item">
            <p style={{ fontSize: "23px" }}>User Register of Month</p>
            <img
              src={assets.totaluser}
              alt=""
              className="img-item"
              style={{ marginTop: "25px" }}
            />
            <h2>20</h2>
          </div>
          <div className="item">
            <p>Total Sold items</p>
            <img
              src={assets.itemSold2}
              alt=""
              className="img-item"
              style={{ marginTop: "25px" }}
            />
            <h2>999</h2>
          </div>
          <div className="item">
            <p style={{ fontSize: "23px" }}>Weekly Revenue</p>
            <img
              src={assets.revenue}
              alt=""
              className="img-item"
              style={{ marginTop: "25px" }}
            />
            <h3>50.000</h3> <span>(triệu đồng)</span>
          </div>
        </div>
      </div>

      <div
        className="content-body"
        style={{
          paddingTop: "50px",
          justifyContent: "space-between",
          gap: "30px",
        }}
      >
        <div className="chart-left">
          <h3>Biểu đồ đường - Doanh thu hàng tháng</h3>
          <Line className="line-chart" data={lineData} />
        </div>

        <div className="chart-content">
          <h3>Biểu đồ cột - Số lượng bán ra</h3>
          <Bar className="bar-chart" data={barData} />
        </div>
        <div className="chart-right">
          <Pie className="pie-chart" data={pieData} />
        </div>
      </div>
    </div>
  );
};

export default OwnerDasboard;
