import React, { useState, useEffect } from "react";
import "./AddProduct.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useTimeout } from "@mui/x-data-grid/internals";
import { Navigate } from "react-router-dom";
import { useNavigate } from "react-router-dom";
const AddProduct = ({ url }) => {
  const navigate = useNavigate();
  const [image, setImage] = useState(false);
  const [data, setData] = useState({
    categoryName: "",
    description: "",
    productName: "",
    price: "",
    description: "",
    categoryId: "",
    stockQuantity: "",
    bestSale: "",
  });

  //get user
  const [cate, setCate] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState("");
  const [bestSale, setbestSale] = useState("");
  const token = localStorage.getItem("access_token");

  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/categories/all`)
        .then((response) => {
          setCate(response.data.data);
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
    formData.append("productName", data.productName);
    formData.append("price", data.price);
    formData.append("description", data.description);
    formData.append("categoryId", selectedUserId);
    formData.append("stockQuantity", data.stockQuantity);
    formData.append("image", image);
    formData.append("bestSale", bestSale);

    try {
      const response = await axios.post(
        `${url}/api/v1/admin/products/add`,
        formData,
        { headers }
      );
      if (response.data.message) {
        setData({
          categoryName: "",
          description: "",
          productName: "",
          price: "",
          description: "",
          categoryId: "",
          stockQuantity: "",
          bestSale: "",
        });
        setImage(null);
        toast.success("Added Product Success");
        setTimeout(() => {
      
          navigate("/admin/product");
        }, 1000);
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
        <h2 className="">Add Product</h2>
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
                <td>Product Name</td>
                <td>
                  <input
                    onChange={onChangeHandler}
                    value={data.productName}
                    type="text"
                    name="productName"
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
                <td>Stock Quantity</td>
                <td>
                  <input
                    name="stockQuantity"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.stockQuantity}
                  />
                </td>
              </tr>
              <tr>
                <td>Category Id</td>
                <td>
                  <select
                    className="ip"
                    onChange={(e) => setSelectedUserId(e.target.value)}
                    name="Manager"
                  >
                    <option value="">-- Select Category --</option>
                    {cate.map((cate) => (
                      <option key={cate.categoryId} value={cate.categoryId}>
                        {cate.categoryName}
                      </option>
                    ))}
                  </select>
                </td>
              </tr>
              <tr>
                <td>Best sale</td>
                <td>
                  <select
                    className="ip"
                    onChange={(e) => setbestSale(e.target.value)}
                    name="bestSale"
                  >
                    <option value="">-- Select --</option>

                    <option key={true} value={true}>
                      true
                    </option>
                    <option key={false} value={false}>
                      false
                    </option>
                  </select>
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

export default AddProduct;
