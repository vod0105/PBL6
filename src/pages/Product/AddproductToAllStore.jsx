import React, { useState, useEffect } from "react";
import "./AddProductToAllStore.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";

const AddProducToAllStore = ({ url }) => {
  const [image, setImage] = useState(false);
  const [data, setData] = useState({
    storeId: "",
    productId: "",
  });

  //get store
  const [store, setStore] = useState([]);
  const [product, SetProduct] = useState([]);
  const [SelectedStoreId, setSelectedStoreId] = useState("");
  const [SelectedProductId, setSelectedProductId] = useState("");
  const token = localStorage.getItem("access_token");

  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/stores/all`)
        .then((response) => {
          setStore(response.data.data);
        })
        .catch((error) => {
          console.error("There was an error fetching users!", error);
        });
    } else {
      console.error("Access token is missing");
    }
  }, []);
  //

  useEffect(() => {
    if (token) {
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      axios
        .get(`${url}/api/v1/public/products/all`)
        .then((response) => {
          SetProduct(response.data.data);
        })
        .catch((error) => {
          console.error("There was an error fetching users!", error);
        });
    } else {
      console.error("Access token is missing");
    }
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

    formData.append("productId", SelectedProductId);

    try {
      const response = await axios.post(
        `${url}/api/v1/admin/products/apply-to-all-stores`,
        formData,
        { headers }
      );
      if (response.data.status) {
       
        toast.success(response.data.message);
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
    // console.log("store", store);
    console.log("SelectedStoreId", SelectedStoreId);
    console.log("productid", SelectedProductId);
  });

  return (
    <div className="add">
      <div className="cover-left1">
        <h2 className="">Add Product To All Store </h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <table className="form-table">
            <tbody>
        
              <tr>
                <td>Select Product</td>
                <td>
                  <select
                    className="ip"
                    onChange={(e) => setSelectedProductId(e.target.value)}
                    name="Manager"
                  >
                    <option value="">-- Select Product --</option>
                    {product.map((vl) => (
                      <option key={vl.productId} value={vl.productId}>
                        {vl.productName}
                      </option>
                    ))}
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

export default AddProducToAllStore;
