import React, { useState, useEffect } from "react";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";

const AddPromotion = ({ url }) => {
  const [image, setImage] = useState(false);
  const [data, setData] = useState({
    promotionName: "",
    discount: "",
    description: "",
    startDate: "",
    endDate: "",
  });

  //get user
  const [cate, setCate] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState("");
  const [bestSale, setbestSale] = useState("");
  const token = localStorage.getItem("access_token");

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
    formData.append("promotionName", data.promotionName);
    formData.append("discount", data.discount);
    formData.append("description", data.description);
    formData.append("startDate", data.startDate);
    formData.append("endDate", data.endDate);
    formData.append("image", image);
    try {
      const response = await axios.post(
        `${url}/api/v1/admin/promotions/add`,
        formData,
        { headers }
      );
      if (response.data.message) {
        setData({
          promotionName: "",
          discount: "",
          description: "",
          startDate: "",
          endDate: "",
        });
        setImage(null);
        toast.success("Added Promotion");
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
    console.log("bestSale", bestSale);
    console.log("data.stockQuantity", data.stockQuantity);
  });

  return (
    <div className="add add-product">
      <div className="cover-left1">
        <h2 className="">Add Promotion</h2>
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
                <td>Promotion Name</td>
                <td>
                  <input
                    onChange={onChangeHandler}
                    value={data.promotionName}
                    type="text"
                    name="promotionName"
                    placeholder="Type here"
                  />
                </td>
              </tr>
              <tr>
                <td>Discount</td>
                <td>
                  <input
                    name="discount"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.discount}
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
              <tr>
                <td>
                  <p>Start Day</p>
                </td>
                <td>
                  <input
                    type="datetime-local"
                    name="startDate"
                    onChange={onChangeHandler}
                    value={data.startDate}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <p>End Day</p>
                </td>
                <td>
                  <input
                    type="datetime-local"
                    name="endDate"
                    onChange={onChangeHandler}
                    value={data.endDate}
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

export default AddPromotion;
