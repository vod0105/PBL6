import React, { useState, useEffect } from "react";
import "./UpdateStore.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useParams } from "react-router-dom";
const UpdateStore = ({ url }) => {
  const [image, setImage] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [dataUpdate, setDataUpdate] = useState([]);
  const { id } = useParams();
  const [data, setData] = useState({
    storeName: "",
    PhoneNumber: "",
    Location: "",
    Latitude: "",
    Open: "",
    Close: "",
    longitude: "",
    apiimg: "",
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

  const base64ToFile = (base64String, fileName) => {
    const [metadata, base64] = base64String.split(",");
    const mimeString = metadata.match(/:(.*?);/)[1]; // Lấy loại MIME

    const byteCharacters = atob(base64);
    const byteNumbers = new Array(byteCharacters.length);
    for (let i = 0; i < byteCharacters.length; i++) {
      byteNumbers[i] = byteCharacters.charCodeAt(i);
    }
    const byteArray = new Uint8Array(byteNumbers);

    const blob = new Blob([byteArray], { type: mimeString });
    return new File([blob], fileName, { type: mimeString });
  };

  // Get store
  useEffect(() => {
    const fetchData = async () => {
      try {
        //   const token = localStorage.getItem("access_token");
        const response = await axios.get(`${url}/api/v1/public/stores/${id}`);

        // truyen du lieu qua data
        setData({
          storeName: response.data.data.storeName,
          PhoneNumber: response.data.data.numberPhone,
          Location: response.data.data.location,
          Latitude: response.data.data.latitude,
          Open: response.data.data.openingTime,
          Close: response.data.data.closingTime,
          longitude: response.data.data.longitude,
          apiimg: response.data.data.image,
        });
        setSelectedUserId(response.data.data.managerId);
        console.log("vao1");
        // console.log("image",response.data.data.image)
        if (response.data.data.image) {
          const file = base64ToFile(
            response.data.data.image,
            "store-image.png"
          );

          setImage(file);
        }
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    // console.log("DAta update", dataUpdate);
    // console.log("image", image);
  }, [data]);

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
    formData.append("phoneNumber", data.PhoneNumber);
    formData.append("location", data.Location);
    formData.append("latitude", data.Latitude);
    formData.append("longitude", data.longitude);
    formData.append("image", image);
    formData.append("openingTime", data.Open);
    formData.append("closingTime", data.Close);
    formData.append("managerId", selectedUserId);
    console.log("phone", data.PhoneNumber);

    try {
      const response = await axios.put(
        `${url}/api/v1/admin/stores/update/${id}`,
        formData,
        { headers }
      );
      if (response.data.message) {
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
        toast.success("Updated Store");
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
        <h2>Update Store</h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <div className="add-img-upload flex-col">
            <p>Upload Image</p>
            <label htmlFor="image">
              <img
                className="img-upload"
                src={
                  image
                    ? URL.createObjectURL(image)
                    : `${url}/api/v1/public/uploads/images/${data.apiimg}`
                }
                // src={`data:image/jpeg;base64,${store.image}`}
                alt=""
              />
            </label>
            <input
              onChange={(e) => setImage(e.target.files[0])}
              type="file"
              id="image"
              hidden
            />
          </div>
          <div className="flex-ip">
            <div className="add-product-name flex-col">
              <p>Store Name</p>
              <input
                onChange={onChangeHandler}
                value={data.storeName}
                type="text"
                name="storeName"
                placeholder="Type here"
              />
            </div>
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
          </div>

          <div></div>
          <div className="flex-ip">
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
          </div>

          <div className="add-category-price flex-col">
            <div className="add-category flex-col">
              <p>Manager</p>
              <select
                className="select-manager"
                onChange={(e) => setSelectedUserId(e.target.value)}
                name="Manager"
                value={selectedUserId}
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
      {/* <div className="cover-right">
        <img src={data.image} alt="" />
      </div> */}
      <ToastContainer />
    </div>
  );
};

export default UpdateStore;
