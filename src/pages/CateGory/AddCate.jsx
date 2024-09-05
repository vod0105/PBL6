import React, { useState, useEffect } from "react";
import "./AddCate.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import {ToastContainer, toast } from "react-toastify";

const Add = ({ url }) => {
  const [image, setImage] = useState(false);
  const [data, setData] = useState({
    storeName: "",
    PhoneNumber: "",
    Location: "",
    Latitude: "",
    Open: "",
    Close: "",
    longitude: "",
  });


  //get user
  const [users, setUsers] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState("");
  const token = localStorage.getItem("access_token");

  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/admin/auth/all_roles`, {
          headers,
          params: { role: "ROLE_OWNER" },
        })
        .then((response) => {
          setUsers(response.data.data);
        })
        .catch((error) => {
          console.error("There was an error fetching users!", error);
        });
    } else {
      console.error("Access token is missing");
    }
  }, []);
  //




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
    };

    const formData = new FormData();
    formData.append("storeName", data.storeName);
    formData.append("phoneNumber", Number(data.PhoneNumber));
    formData.append("location", data.Location);
    formData.append("latitude", data.Latitude);
    formData.append("longitude", data.longitude);
    formData.append("image", image);
    formData.append("openingTime", data.Open);
    formData.append("closingTime", data.Close);
    formData.append("managerId", selectedUserId);

    try {
      const response = await axios.post(
        `${url}/api/v1/admin/stores/add`,
        formData,
        { headers }
      );
      if (response.data.status) {
        setData({
          name: "",
          PhoneNumber: "",
          Location: "",
          Latitude: "",
          Open: "",
          Close: "",
          longitude: "",
        });
        setImage(null);
        toast.success("Added Store");
      } else {
        toast.error(response.data.message);
      }
    } catch (error) {
      if (error.response) {
        console.error("Error Response Data:", error.response.data);

        toast.error(error.response.data.message || "Something went wrong.");
      } else {
        console.error("Error:", error.message);
        toast.error("Something went wrong.");
      }
    }
  };

  return (
    <div className="add">
      <div className="cover-left">
        {" "}
        <h2>Add Store</h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <div className="add-img-upload flex-col">
            <p>Upload Image</p>
            <label htmlFor="image">
              <img
                className="img-upload"
                src={image ? URL.createObjectURL(image) : assets.upload_area}
                alt=""
              />
            </label>
            <input
              onChange={(e) => setImage(e.target.files[0])}
              type="file"
              id="image"
              hidden
              required
            />
          </div>
          <div className="flex-ip">
            <div className="add-product-name flex-col">
              <p>Store Name</p>
              <input
                onChange={onChangeHandler}
                value={data.name}
                type="text"
                name="storeName"
                placeholder="Type here"
              />
            </div>
            <div>
              <div className="add-product-description flex-col">
                <p> longitude</p>
                <input
                  name="longitude"
                  type="text"
                  placeholder="Write content here"
                  id=""
                  onChange={onChangeHandler}
                  value={data.longitude}
                ></input>
              </div>
            </div>
          </div>
          <div className="add-product-description flex-col">
            <p>Phone Number</p>
            <input
              name="PhoneNumber"
              type="text"
              placeholder="Write content here"
              id=""
              onChange={onChangeHandler}
              value={data.PhoneNumber}
            ></input>
          </div>
          <div></div>
          <div className="flex-ip">
            <div className="add-product-description flex-col">
              <p>Location</p>
              <input
                name="Location"
                type="text"
                placeholder="Write content here"
                id=""
                onChange={onChangeHandler}
                value={data.Location}
              ></input>
            </div>
            <div className="add-product-description flex-col">
              <p> Latitude</p>
              <input
                name="Latitude"
                type="text"
                placeholder="Write content here"
                id=""
                onChange={onChangeHandler}
                value={data.Latitude}
              ></input>
            </div>
          </div>
          <div className="flex-ip">
            <div className="add-product-description flex-col">
              <p>Open</p>
              <input
                name="Open"
                type="text"
                placeholder="Write content here"
                id=""
                onChange={onChangeHandler}
                value={data.Open}
              ></input>
            </div>
            <div className="add-product-description flex-col">
              <p> Close</p>
              <input
                name="Close"
                type="text"
                placeholder="Write content here"
                id=""
                onChange={onChangeHandler}
                value={data.Close}
              ></input>
            </div>
          </div>

          <div className="add-category-price">
            <div className="add-category flex-col">
              <p>Manager</p>
              <select
                className="select-manager"
                onChange={(e) => setSelectedUserId(e.target.value)}
                name="Manager"
              >
                <option value="">-- Select Manager --</option>
                {users.map((user) => (
                  <option key={user.id} value={user.id}>
                    {user.fullName}
                  </option>
                ))}
              </select>
            </div>
          </div>

          <button className="add-btn" type="submit">
            Add
          </button>
        </form>
      </div>
      <div className="cover-right">
        <img src={assets.store} alt="" />
        
      </div>
      <ToastContainer/>
    </div>
  );
};

export default Add;
