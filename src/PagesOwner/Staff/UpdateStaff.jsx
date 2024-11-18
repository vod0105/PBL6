import React, { useState, useEffect } from "react";
import "../Staff/AddStaff.css";
// import "./AddStaff.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useParams } from "react-router-dom";
import SoundNotification from "../../components/Notify/Notify.jsx";
import { useNavigate } from "react-router-dom";
const UpdateStaff = ({ url }) => {
  const [image, setImage] = useState(false);
  const navigate = useNavigate();
  const [data, setData] = useState({
    id: "",
    employeeName: "",
    staff_code: "",
    department: "",
    storeId: "",
  });

  //get user
  const [cate, setCate] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState("");
  const [bestSale, setbestSale] = useState("");
  const token = localStorage.getItem("access_token");

  //
  const { id } = useParams();
  //
  useEffect(() => {
    const fetchData = async () => {
      try {
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };
        const response = await axios.get(`${url}/api/v1/owner/staff/${id}`, {
          headers,
        });
        console.log("res", response);
        setData({
          employeeName: response.data.data[0].employeeName,
          staff_code: response.data.data[0].staff_code,
          department: response.data.data[0].department,

          storeId: response.data.data[0].storeId,
        });
      } catch (err) {
      } finally {
      }
    };

    fetchData();
  }, []);

  const onChangeHandler = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setData((data) => ({ ...data, [name]: value }));
  };

  const onSubmitHandler = async (event) => {
    event.preventDefault();
    const tk = localStorage.getItem("access_token");

    if (!tk) {
      toast.error("Access token is missing");
      return;
    }

    const headers = {
      Authorization: `Bearer ${tk}`,
      "Content-Type": "application/json",
    };

    const formData = new FormData();
    formData.append("employeeName", data.employeeName);
    formData.append("staff_code", data.staff_code);
    formData.append("department", data.department);
    formData.append("storeId", data.storeId);

    try {
      const response = await axios.put(
        `${url}/api/v1/owner/staff/update/${id}`,
        formData,
        { headers }
      );
      
      if (response.data.success) {
        setData({
          employeeName: "",
          staff_code: "",
          department: "",
          storeId: "",
        });
        navigate("/owner/product");
        toast.success("Updated Staff Success");
      } else {
        toast.error(response.data.message);
        console.log("2");
      }
    } catch (error) {
      if (error.response) {
        console.error("Error Response Data:", error.response.data);
        console.log("3");

        toast.error(error.response.data.message || "Something went wrong.");
      } else {
        console.error("Error:", error.message);
        console.log("4");
        toast.error("Something went wrong.");
      }
    }
  };

  return (
    <div className="add add-product">
      <div className="cover-left1">
        <h2 className="">Update Staff </h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <table className="form-table">
            <tbody>
              <tr>
                <td>Employee Name</td>
                <td>
                  <input
                    onChange={onChangeHandler}
                    value={data.employeeName}
                    type="text"
                    name="employeeName"
                    placeholder="Type here"
                  />
                </td>
              </tr>
              <tr>
                <td>Staff code</td>
                <td>
                  <input
                    name="staff_code"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.staff_code}
                  />
                </td>
              </tr>
              <tr>
                <td>Department</td>
                <td>
                  <input
                    name="department"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.department}
                  />
                </td>
              </tr>
              <tr>
                <td>Store ID</td>
                <td>
                  <input
                    name="storeId"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.storeId}
                  />
                </td>
              </tr>
            </tbody>
          </table>

          <button className="add-btn" type="submit">
            Update
          </button>
        </form>
      </div>

      <ToastContainer />
    </div>
  );
};

export default UpdateStaff;
