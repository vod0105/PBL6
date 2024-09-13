import React from "react";
import { Line, Bar, Pie } from "react-chartjs-2";
import "./Dashboard.css";
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

const Dashboard = () => {
  // Dữ liệu cho biểu đồ đường
  const lineData = {
    labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6"],
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
    labels: ["Sản phẩm A", "Sản phẩm B", "Sản phẩm C", "Sản phẩm D"],
    datasets: [
      {
        label: "Số lượng bán ra",
        data: [400, 300, 500, 200],
        backgroundColor: [
          "rgba(255,99,132,0.2)",
          "rgba(54,162,235,0.2)",
          "rgba(255,206,86,0.2)",
          "rgba(75,192,192,0.2)",
        ],
        borderColor: [
          "rgba(255,99,132,1)",
          "rgba(54,162,235,1)",
          "rgba(255,206,86,1)",
          "rgba(75,192,192,1)",
        ],
        borderWidth: 1,
      },
    ],
  };

  //   // Dữ liệu cho biểu đồ tròn
  //   const pieData = {
  //     labels: ['Sản phẩm A', 'Sản phẩm B', 'Sản phẩm C', 'Sản phẩm D'],
  //     datasets: [
  //       {
  //         data: [300, 50, 100, 150],
  //         backgroundColor: ['rgba(255,99,132,0.6)', 'rgba(54,162,235,0.6)', 'rgba(255,206,86,0.6)', 'rgba(75,192,192,0.6)'],
  //         hoverBackgroundColor: ['rgba(255,99,132,1)', 'rgba(54,162,235,1)', 'rgba(255,206,86,1)', 'rgba(75,192,192,1)'],
  //       },
  //     ],
  //   };

  return (
    <div className="dashboard">
      <div className="content-header">
        <div className="list">
          <div className="item">
            <p>BudGet</p>
            <img src={assets.dola} alt="" className="img-item" />
            
           <h2>$24k</h2>
          </div>
          <div className="item">
            <p>BudGet</p>
            <img src={assets.dola} alt="" className="img-item" />
            <h2>$24k</h2>
          </div>
          <div className="item">
            <p>BudGet</p>
            <img src={assets.dola} alt="" className="img-item" />
            <h2>$24k</h2>
          </div>
          <div className="item">
            <p>BudGet</p>
            <img src={assets.dola} alt="" className="img-item" />
            <h2>$24k</h2>
          </div>
        </div>
      </div>

      <div className="content-body">
        <div className="chart-left">
          <h3>Biểu đồ đường - Doanh thu hàng tháng</h3>
          <Line data={lineData} />
        </div>

        <div className="chart-right">
          <h3>Biểu đồ cột - Số lượng bán ra</h3>
          <Bar data={barData} />
        </div>
      </div>

      {/* <div>
        <h3>Biểu đồ tròn - Phân phối sản phẩm</h3>
        <Pie data={pieData} />
      </div> */}
    </div>
  );
};

export default Dashboard;
