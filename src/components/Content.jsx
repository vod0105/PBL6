import React, { useEffect, useState } from "react";
import ContentHeader from "./ContentHeader";
import "../styles/Content.css";
import Profile from "./Profile";
import "bootstrap/dist/css/bootstrap.min.css";
import axios from "axios";
import LoadingSpinner from "../Action/LoadingSpiner";
const Content = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem("access_token");
        const response = await axios.get(
          "http://192.168.1.34:8080/api/v1/public/stores/all"
          // {
          //   headers: {
          //     Authorization: `Bearer ${token}`,
          //   },
          // }
        );
        setData(response.data);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return (
      <p>
        <LoadingSpinner />
      </p>
    );
  }

  // Hiển thị nếu có lỗi xảy ra
  if (error) {
    return <p>Error: {error.message}</p>;
  }
  console.log("DAta", data);

  return (
    <div className="content">
      <ContentHeader />
      <div className="test">
        <div className="left-content">
          <table className="table text-center">
            <thead className="table-dark">
              <tr>
                <th scope="col">#</th>
                <th scope="col">ID</th>
                <th scope="col">Name</th>
                <th scope="col">Sửa</th>
                <th scope="col">Xóa</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">1</th>
                <td>Mark</td>
                <td>{data.data[0].name}</td>
                <td>
                  <button type="button" class="btn btn-primary">
                    Primary
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-danger">
                    Danger
                  </button>
                </td>
              </tr>
              <tr>
                <th scope="row">1</th>
                <td>Mark</td>
                <td>{data.data[1].name}</td>
                <td>
                  <button type="button" class="btn btn-primary">
                    Primary
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-danger">
                    Danger
                  </button>
                </td>
              </tr>{" "}
              <tr>
                <th scope="row">1</th>
                <td>Mark</td>
                <td>{data.data[2].name}</td>
                <td>
                  <button type="button" class="btn btn-primary">
                    Primary
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-danger">
                    Danger
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <Profile />
      </div>
    </div>
  );
};

export default Content;
