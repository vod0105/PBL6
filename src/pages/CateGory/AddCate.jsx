import React, { useState, useEffect } from "react";
import "./AddCate.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";

const AddCate = ({ url }) => {
  const [image, setImage] = useState(false);
  const [data, setData] = useState({
    categoryName: "",
    description: "",
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
    formData.append("categoryName", data.categoryName);
    formData.append("image", image);
    formData.append("description", data.description);

    try {
      const response = await axios.post(
        `${url}/api/v1/admin/categories/add`,
        formData,
        { headers }
      );
      if (response.data.success) {
        setData({
          categoryName: "",
          description: "",
        });
        setImage(null);
        toast.success("Added Category");
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
        <h2 className="">Add Category</h2>
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
              <p>CateGory Name</p>
              <input
                onChange={onChangeHandler}
                value={data.categoryName}
                type="text"
                name="categoryName"
                placeholder="Type here"
                required
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
                  required
                ></input>
              </div>
            </div>
          </div>

          <button className="add-btn" type="submit">
            Add
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

export default AddCate;
