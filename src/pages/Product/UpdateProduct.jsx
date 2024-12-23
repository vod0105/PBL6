import React, { useState, useEffect } from "react";
import "./AddProduct.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useParams } from "react-router-dom";
import { useNavigate } from "react-router-dom";
const UpdateProduct = ({ url }) => {
  const { id } = useParams();
  const [image, setImage] = useState(false);
  const [cate, setCate] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState();
  const [selectbestSale, setselectbestSale] = useState();
  const token = localStorage.getItem("access_token");
  const navigate = useNavigate();
  const [data, setData] = useState({
    categoryName: "",
    description: "",
    productName: "",
    price: "",
    categoryId: "",
    stockQuantity: "",
  });
  const base64ToFile = (base64String, filename) => {
    const arr = base64String.split(",");
    const mime = arr[0].match(/:(.*?);/)[1];
    const bstr = atob(arr[1]);
    let n = bstr.length;
    const u8arr = new Uint8Array(n);

    while (n--) {
      u8arr[n] = bstr.charCodeAt(n);
    }

    return new File([u8arr], filename, { type: mime });
  };
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`${url}/api/v1/public/products/${id}`);
        setData({
          categoryName: response.data.data[0].categoryName,
          description: response.data.data[0].description,
          productName: response.data.data[0].productName,
          price: response.data.data[0].price,
          stockQuantity: response.data.data[0].stockQuantity,
          categoryId: response.data.data[0].category.categoryId,

          apiimg: response.data.data[0].image,
        });

        setSelectedUserId(response.data.data[0].category.categoryId);
        setselectbestSale(response.data.data[0].bestSale);
        // console.log("vao");
        // const base64Image = `data:image/png;base64,${data.apiimg}`;
        // const file = base64ToFile(base64Image, "image.png");
        // await setImage(file);
      } catch (err) {
      } finally {
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    console.log("selectbestSale", selectbestSale);
  });

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
  // const handleChange = (e) => {
  //   const value = e.target.value;
  //   // Cập nhật giá trị nếu có lựa chọn mới, nếu không giữ giá trị mặc định
  //   setSelectedUserId(value !== "" ? value : selectedUserId);
  // };

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
    formData.append("bestSale", selectbestSale);

    try {
      const response = await axios.put(
        `${url}/api/v1/admin/products/update/${id}`,
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
        await toast.success("Update Product Success");
        setTimeout(() => {
          navigate("/admin/product");
        }, 1500);
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
    console.log("image", image);
  });

  return (
    <div className="add add-product">
      <div className="cover-left1">
        <h2 className="">Update Product</h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <table className="form-table">
            <tbody>
              <tr>
                <td className="td-text">Upload Image</td>
                <td>
                  <label htmlFor="image">
                    <img
                      className="img-upload"
                      src={
                        image
                          ? URL.createObjectURL(image)
                          : `${url}/api/v1/public/uploads/images/${data.apiimg}`
                      }
                      alt=""
                    />
                  </label>
                  <input
                    onChange={(e) => setImage(e.target.files[0])}
                    type="file"
                    id="image"
                    hidden
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
                    value={selectedUserId}
                    onChange={(e) => setSelectedUserId(e.target.value)}
                    name="Manager"
                  >
                    <option value="0">-- Select Category --</option>
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
                    value={selectbestSale}
                    onChange={(e) => setselectbestSale(e.target.value)}
                    name="bestSale"
                  >
                    <option value="0">-- Select --</option>

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
          className="img-upload"
          src={
            image
              ? URL.createObjectURL(image)
              :  `${url}/api/v1/public/uploads/images/${data.apiimg}`
          }
          alt=""
        />
      </div>
      <ToastContainer />
    </div>
  );
};

export default UpdateProduct;
