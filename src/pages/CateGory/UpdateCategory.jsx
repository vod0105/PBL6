import React, { useState, useEffect } from "react";
import "./UpdateCategory.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useParams } from "react-router-dom";
const UpdateCategory = ({ url }) => {
  const [image, setImage] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [dataUpdate, setDataUpdate] = useState([]);
  const { id } = useParams();
  const [data, setData] = useState({
    categoryName: "",
    description: "",
  });

  const token = localStorage.getItem("access_token");

  useEffect(() => {
    const fetchData = async () => {
      try {
        //   const token = localStorage.getItem("access_token");
        const response = await axios.get(
          `${url}/api/v1/public/categories/${id}`
        );

        // truyen du lieu qua data
        setData({
          image: response.data.data.image,
          categoryName: response.data.data.categoryName,
          description: response.data.data.description,
        });
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    console.log("DAta update", dataUpdate);
    console.log("DAta", data);
  }, [data]);

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
    formData.append("categoryName", data.categoryName);
    formData.append("image", image);
    formData.append("description", data.description);
    console.log(image);
    try {
      const response = await axios.put(
        `${url}/api/v1/admin/categories/update/${id}`,
        formData,
        { headers }
      );
      if (response.data.message) {
        setData({
          categoryName: "",
          description: "",
        });
        setImage(null);
        toast.success("Updated Category");
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
    console.log(data);
  });

  return (
    <div className="add">
      <div className="cover-left">
        {" "}
        <h2 className="">Update Category</h2>
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
              // required
            />
          </div>
          <div className="flex-ip">
            <div className="add-product-name flex-col">
              <p>CateGory Name</p>
              <input
                onChange={onChangeHandler}
                value={data.categoryName}
                type="text"
                name="categoryName"
                placeholder="Type here"
              />
            </div>
            <div>
              <div className="add-product-description flex-col">
                <p> Description</p>
                <input
                  name="description"
                  type="text"
                  placeholder="Write content here"
                  id=""
                  onChange={onChangeHandler}
                  className="ipdes"
                  value={data.description}
                ></input>
              </div>
            </div>
          </div>

          <button className="add-btn" type="submit">
            Update
          </button>
        </form>
      </div>
      <div className="cover-right">
        <img src={assets.category} alt="" className="img-cate" />
      </div>
      <ToastContainer />
    </div>
  );
};

export default UpdateCategory;
