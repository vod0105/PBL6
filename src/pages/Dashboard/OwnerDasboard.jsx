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
import SoundNotification from "../../components/Notify/Notify";

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
  const [weekly, setWeekly] = useState("");

  const [ordermonth, setordermonth] = useState("");
  const [allbudger, setallbudger] = useState("");

  const [registermonth, setregistermonth] = useState("");
  const [listDataBudgetOfYear, setlistDataBudgetOfYear] = useState([]);
  const [lineData, setLineData] = useState({
    labels: [],
    datasets: [
      {
        label: "Doanh thu",
        data: [],
        borderColor: "rgba(75,192,192,1)",
        backgroundColor: "rgba(75,192,192,0.2)",
        fill: true,
      },
    ],
  });
  const [barData, setBarData] = useState({
    labels: [],
    datasets: [
      {
        label: "Số lượng bán ra",
        data: [],
        backgroundColor: [
          "rgba(255,99,132,0.2)",
          "rgba(54,162,235,0.2)",
          "rgba(255,206,86,0.2)",
          "rgba(75,192,192,0.2)",
          "rgba(153,102,255,0.2)",
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
          "rgba(255,99,132,0.2)",
          "rgba(54,162,235,0.2)",
          "rgba(255,206,86,0.2)",
          "rgba(75,192,192,0.2)",
          "rgba(153,102,255,0.2)",
        ],
        borderWidth: 1,
      },
    ],
  });
  useEffect(() => {
    const fetchData = async () => {
      try {
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };

        const rsordermonth = await axios.get(
          `${url}/api/v1/owner/display/order/month`,
          { headers }
        );
        console.log("rsorder", rsordermonth);

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

        const rs = await axios.get(`${url}/api/v1/owner/display/budget/all`, {
          headers,
        });

        setallbudger(rs.data.data); // Cập nhật state với dữ liệu phản hồi từ API
      } catch (error) {
        console.error("Lỗi khi lấy dữ liệu:", error);
      }
    };

    fetchData2();
  }, []);

  // do thi 1
  useEffect(() => {
    const fetchData2 = async () => {
      try {
        const currentYear = new Date().getFullYear();
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };

        const rs = await axios.get(
          `${url}/api/v1/owner/display/total/year/${currentYear}`,
          {
            headers,
          }
        );
        const labels = Object.keys(rs.data.data);
        const data = Object.values(rs.data.data).map((value) =>
          value === null ? 0 : value
        );

        setLineData({
          labels,
          datasets: [
            {
              label: "Doanh thu",
              data,
              borderColor: "rgba(75,192,192,1)",
              backgroundColor: "rgba(75,192,192,0.2)",
              fill: true,
            },
          ],
        });
      } catch (error) {
        console.error("Lỗi khi lấy dữ liệu:", error);
      }
    };

    fetchData2();
  }, []);
  // bieu do so 2

  useEffect(() => {
    const fetchData2 = async () => {
      try {
        const currentYear = new Date().getFullYear();
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };

        const rs = await axios.get(
          `${url}/api/v1/owner/display/count/products?module=year`,
          {
            headers,
          }
        );
        const labels = Object.keys(rs.data.data);
        const data = Object.values(rs.data.data).map((value) =>
          value === null ? 0 : value
        );

        setBarData({
          labels,
          datasets: [
            {
              label: "Số lượng ",
              data,
              backgroundColor: [
                "rgba(255, 99, 132, 0.5)", // Màu hồng
                "rgba(54, 162, 235, 0.8)", // Màu xanh dương
                "rgba(255, 206, 86, 0.7)", // Màu vàng
                "rgba(75, 192, 192, 0.6)", // Màu xanh ngọc
                "rgba(153, 102, 255, 0.4)", // Màu tím nhạt
                "rgba(255, 159, 64, 0.3)", // Màu cam
                "rgba(255, 99, 132, 0.2)", // Màu hồng nhạt
                "rgba(54, 162, 235, 0.9)", // Màu xanh dương đậm
                "rgba(75, 192, 192, 0.5)", // Màu xanh lục nhạt
                "rgba(255, 206, 86, 0.1)",
              ],
              borderColor: [
                "rgba(255, 99, 132, 0.5)", // Màu hồng
                "rgba(54, 162, 235, 0.8)", // Màu xanh dương
                "rgba(255, 206, 86, 0.7)", // Màu vàng
                "rgba(75, 192, 192, 0.6)", // Màu xanh ngọc
                "rgba(153, 102, 255, 0.4)", // Màu tím nhạt
                "rgba(255, 159, 64, 0.3)", // Màu cam
                "rgba(255, 99, 132, 0.2)", // Màu hồng nhạt
                "rgba(54, 162, 235, 0.9)", // Màu xanh dương đậm
                "rgba(75, 192, 192, 0.5)", // Màu xanh lục nhạt
                "rgba(255, 206, 86, 0.1)",
              ],
              fill: true,
            },
          ],
        });
      } catch (error) {
        console.error("Lỗi khi lấy dữ liệu:", error);
      }
    };

    fetchData2();
  }, []);

  //all weekly
  useEffect(() => {
    const fetchData2 = async () => {
      try {
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };

        const rs = await axios.get(`${url}/api/v1/owner/display/total/week`, {
          headers,
        });
        console.log(`data`,rs.data.data);
        const total = Object.values(rs.data.data)
        .filter(value => value !== null)
        .reduce((sum, currentValue) => sum + currentValue, 0);
        console.log(`total`,total);
        setWeekly(total/1000000);
      } catch (error) {
        console.error("Lỗi khi lấy dữ liệu:", error);
      }
    };

    fetchData2();
  }, []);

  // Dữ liệu cho biểu đồ đường
  // const lineData = {
  //   labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Thán1"],
  //   datasets: [
  //     {
  //       label: "Doanh thu",
  //       data: [1200, 1900, 3000, 5000, 2400, 3500],
  //       borderColor: "rgba(75,192,192,1)",
  //       backgroundColor: "rgba(75,192,192,0.2)",
  //       fill: true,
  //     },
  //   ],
  // };

  // Dữ liệu cho biểu đồ cột
  // const barData = {
  //   labels: [
  //     "Sản phẩm A",
  //     "Sản phẩm B",
  //     "Sản phẩm C",
  //     "Sản phẩm D",
  //     "Sản phẩm E",
  //     "Sản phẩm f",
  //     "Sản phẩm g",
  //   ],
  //   datasets: [
  //     {
  //       label: "Số lượng bán ra",
  //       data: [400, 300, 500, 200, 350],
  //       backgroundColor: [
  //         "rgba(255,99,132,0.2)",
  //         "rgba(54,162,235,0.2)",
  //         "rgba(255,206,86,0.2)",
  //         "rgba(75,192,192,0.2)",
  //         "rgba(153,102,255,0.2)",
  //       ],
  //       borderColor: [
  //         "rgba(255,99,132,1)",
  //         "rgba(54,162,235,1)",
  //         "rgba(255,206,86,1)",
  //         "rgba(75,192,192,1)",
  //         "rgba(153,102,255,1)",
  //       ],
  //       borderWidth: 1,
  //     },
  //   ],
  // };

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
      <SoundNotification url={url} />
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
            <h3>{allbudger == null ? 0 : Math.floor(allbudger / 1)}</h3>{" "}
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
            <p>Total Order items</p>
            <img
              src={assets.itemSold2}
              alt=""
              className="img-item"
              style={{ marginTop: "25px" }}
            />
            <h2>{ordermonth}</h2>
          </div>
          <div className="item">
            <p style={{ fontSize: "23px" }}>Weekly Revenue</p>
            <img
              src={assets.revenue}
              alt=""
              className="img-item"
              style={{ marginTop: "25px" }}
            />
            <h3>{weekly}</h3> <span>(triệu đồng)</span>
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
        {/* <div className="chart-right">
          <Pie className="pie-chart" data={pieData} />
        </div> */}
      </div>
    </div>
  );
};

export default OwnerDasboard;
