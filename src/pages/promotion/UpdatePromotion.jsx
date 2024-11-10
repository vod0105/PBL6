import React, { useState, useEffect } from "react";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useParams } from "react-router-dom";

const UpdatePromotion = ({ url }) => {
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

  const { id } = useParams();
  useEffect(() => {
    const fetchData = async () => {
      try {
        //   const token = localStorage.getItem("access_token");
        const response = await axios.get(
          `${url}/api/v1/public/promotions/${id}`
        );

        // truyen du lieu qua data
        setData({
          promotionName: response.data.data.name,
          discount: response.data.data.discountPercentage,
          description: response.data.data.description,
          startDate: response.data.data.startDate,
          endDate: response.data.data.endDate,
          image: response.data.data.image,
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
    };

    const formData = new FormData();
    formData.append("promotionName", data.promotionName);
    formData.append("discount", data.discount);
    formData.append("description", data.description);
    formData.append("startDate", data.startDate);
    formData.append("endDate", data.endDate);
    formData.append("image", image);
    try {
      const response = await axios.put(
        `${url}/api/v1/admin/promotions/update/${id}`,
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
    console.log("id", id);
  });

  return (
    <div className="add add-product">
      <div className="cover-left1">
        <h2 className="">Update Promotion</h2>
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
                          : `data:image/png;base64,${data.image}`
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
            Update
          </button>
        </form>
      </div>
      {/* <div className="cover-right">
        <img
          className="img-uploa  d"
          src={image ? URL.createObjectURL(image) : assets.upload_area}
          alt=""
        />
      </div> */}
      <ToastContainer />
    </div>
  );
};

export default UpdatePromotion;
