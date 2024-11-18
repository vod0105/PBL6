// import React from 'react'

// const AddCombo = () => {
//   return (
//     <div>

//     </div>
//   )
// }

// export default AddCombo;

import React, { useState, useEffect } from "react";
import "./AddCombo.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";

const AddCombo = ({ url }) => {
  const [image, setImage] = useState(false);
  const [data, setData] = useState({
    comboName: "",
    price: "",
    description: "",
  });

  //get user
  const [cate, setCate] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState("");
  const [bestSale, setbestSale] = useState("");
  const token = localStorage.getItem("access_token");

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
    formData.append("comboName", data.comboName);
    formData.append("price", data.price);
    formData.append("description", data.description);
    formData.append("image", image);
    formData.append("numberDrinks", data.numberDrinks);

    try {
      const response = await axios.post(
        `${url}/api/v1/admin/combo/add`,
        formData,
        { headers }
      );
      if (response.data.message) {
        setData({
          comboName: "",
          price: "",
          description: "",
          numberDrinks: "",
        });
        setImage(null);
        toast.success("Added Combo Success");
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
  useEffect(() => {
    console.log("data", data);

    console.log("selectedUserId", selectedUserId);
    console.log("data.price", data.price);
    console.log("data.comboName", data.comboName);
    console.log("data.description", data.description);
  });

  return (
    <div className="add add-product">
      <div className="cover-left1">
        <h2 className="">Add Combo</h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <table className="form-table">
            <tbody>
              <tr>
                <td className="td-text">Upload Image</td>
                <td>
                  <label htmlFor="image">
                    <img
                      className="img-uploa  d"
                      src={
                        image ? URL.createObjectURL(image) : assets.upload_area
                      }
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
                </td>
              </tr>
              <tr>
                <td>Combo Name</td>
                <td>
                  <input
                    onChange={onChangeHandler}
                    value={data.comboName}
                    type="text"
                    name="comboName"
                    placeholder="Type here"
                  />
                </td>
              </tr>
              <tr>
                <td>Price</td>
                <td>
                  <input
                    name="price"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.price}
                  />
                </td>
              </tr>
              <tr>
                <td>Number of drinks</td>
                <td>
                  <input
                    name="numberDrinks"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.numberDrinks}
                  />
                </td>
              </tr>
              <tr>
                <td>Description</td>
                <td>
                  <input
                    name="description"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.description}
                  />
                </td>
              </tr>
            </tbody>
          </table>

          <button className="add-btn" type="submit">
            Add
          </button>
        </form>
      </div>
      <div className="cover-right">
        <img
          className="img-uploa  d"
          src={image ? URL.createObjectURL(image) : assets.upload_area}
          alt=""
        />
      </div>
      <ToastContainer />
    </div>
  );
};

export default AddCombo;
