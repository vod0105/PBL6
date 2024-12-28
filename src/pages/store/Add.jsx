// import React, { useState, useEffect } from "react";
// import "./adddemo.css";
// import { assets } from "../../assets/assets.js";
// import axios from "axios";
// import { ToastContainer, toast } from "react-toastify";
// import { useNavigate } from "react-router-dom";

// const Add = ({ url }) => {
//   const navigate = useNavigate();
//   const [image, setImage] = useState(false);
//   const [data, setData] = useState({
//     storeName: "",
//     PhoneNumber: "",
//     Location: "",
//     Latitude: "",
//     Open: "",
//     Close: "",
//     longitude: "",
//   });

//   //get user
//   const [users, setUsers] = useState([]);
//   const [selectedUserId, setSelectedUserId] = useState("");
//   const token = localStorage.getItem("access_token");

//   useEffect(() => {
//     if (token) {
//       const headers = {
//         Authorization: `Bearer ${token}`,
//         "Content-Type": "application/json",
//       };
//       axios
//         .get(`${url}/api/v1/admin/auth/all_roles`, {
//           headers,
//           params: { role: "ROLE_OWNER" },
//         })
//         .then((response) => {
//           setUsers(response.data.data);
//         })
//         .catch((error) => {
//           console.error("There was an error fetching users!", error);
//         });
//     } else {
//       console.error("Access token is missing");
//     }
//   }, []);
//   //
//   useEffect(() => {
//     console.log("date", data.Open);
//     console.log("date", data.storeName);
//   });

//   const onChangeHandler = (event) => {
//     const name = event.target.name;
//     const value = event.target.value;
//     setData((data) => ({ ...data, [name]: value }));
//   };

//   const onSubmitHandler = async (event) => {
//     event.preventDefault();
//     const tk = localStorage.getItem("access_token");

//     if (!tk) {
//       toast.error("Access token is missing");
//       return;
//     }

//     const headers = {
//       Authorization: `Bearer ${tk}`,
//     };

//     const formData = new FormData();
//     formData.append("storeName", data.storeName);
//     formData.append("phoneNumber", Number(data.PhoneNumber));
//     formData.append("location", data.Location);
//     formData.append("latitude", data.Latitude);
//     formData.append("longitude", data.longitude);
//     formData.append("image", image);
//     formData.append("openingTime", data.Open);
//     formData.append("closingTime", data.Close);
//     formData.append("managerId", selectedUserId);

//     try {
//       const response = await axios.post(
//         `${url}/api/v1/admin/stores/add`,
//         formData,
//         { headers }
//       );
//       if (response.data.message) {
//         setData({
//           name: "",
//           PhoneNumber: "",
//           Location: "",
//           Latitude: "",
//           Open: "",
//           Close: "",
//           longitude: "",
//         });
//         setImage(null);
//         toast.success("Added Store");
//         setTimeout(() => {
//           navigate("/admin/product");
//         }, 1000);
//       } else {
//         toast.error(response.data.message);
//       }
//     } catch (error) {
//       if (error.response) {
//         console.error("Error Response Data:", error.response.data);

//         toast.error(error.response.data.message || "Something went wrong.");
//       } else {
//         console.error("Error:", error.message);
//         toast.error("Something went wrong.");
//       }
//     }
//   };

//   return (
//     <div className="add">
//       <div className="cover-left">
//         <h2 className="h2-add">Add Store</h2>
//         <form className="flex-col" onSubmit={onSubmitHandler}>
//           <table className="table">
//             <tbody>
//               <tr>
//                 <td colSpan="2">
//                   <div className="add-img-upload">
//                     <p>Upload Image</p>
//                     <label htmlFor="image">
//                       <img
//                         className="img-upload"
//                         src={
//                           image
//                             ? URL.createObjectURL(image)
//                             : assets.upload_area
//                         }
//                         alt=""
//                       />
//                     </label>
//                     <input
//                       onChange={(e) => setImage(e.target.files[0])}
//                       type="file"
//                       id="image"
//                       hidden
//                       required
//                     />
//                   </div>
//                 </td>
//               </tr>
//               <tr>
//                 <td>
//                   <p>Store Name</p>
//                   <input
//                     onChange={onChangeHandler}
//                     value={data.name}
//                     type="text"
//                     name="storeName"
//                     placeholder="Type here"
//                   />
//                 </td>
//                 <td>
//                   <p>Longitude</p>
//                   <input
//                     name="longitude"
//                     type="text"
//                     placeholder="Write content here"
//                     onChange={onChangeHandler}
//                     value={data.longitude}
//                   />
//                 </td>
//               </tr>
//               <tr>
//                 <td>
//                   <p>Phone Number</p>
//                   <input
//                     name="PhoneNumber"
//                     type="text"
//                     placeholder="Write content here"
//                     onChange={onChangeHandler}
//                     value={data.PhoneNumber}
//                   />
//                 </td>
//                 <td>
//                   <p>Location</p>
//                   <input
//                     name="Location"
//                     type="text"
//                     placeholder="Write content here"
//                     onChange={onChangeHandler}
//                     value={data.Location}
//                   />
//                 </td>
//               </tr>
//               <tr>
//                 <td>
//                   <p>Latitude</p>
//                   <input
//                     name="Latitude"
//                     type="text"
//                     placeholder="Write content here"
//                     onChange={onChangeHandler}
//                     value={data.Latitude}
//                   />
//                 </td>
//                 <td>
//                   <p>Open</p>
//                   <input
//                     type="datetime-local"
//                     name="Open"
//                     onChange={onChangeHandler}
//                     value={data.Open}
//                   />
//                 </td>
//               </tr>
//               <tr>
//                 <td>
//                   <p>Close</p>
//                   <input
//                     type="datetime-local"
//                     name="Close"
//                     onChange={onChangeHandler}
//                     value={data.Close}
//                   />
//                 </td>
//                 <td>
//                   <p>Manager</p>
//                   <select
//                     className="select-manager"
//                     onChange={(e) => setSelectedUserId(e.target.value)}
//                     name="Manager"
//                   >
//                     <option value="">-- Select Manager --</option>
//                     {users.map((user) => (
//                       <option key={user.id} value={user.id}>
//                         {user.fullName}
//                       </option>
//                     ))}
//                   </select>
//                 </td>
//               </tr>
//             </tbody>
//           </table>
//           <button className="add-btn" type="submit">
//             Add
//           </button>
//         </form>
//       </div>
//       <div className="cover-right"></div>

//       <ToastContainer />
//     </div>
//   );
// };

// export default Add;
import React, { useState, useEffect } from "react";
import "./adddemo.css";
import { assets } from "../../assets/assets.js";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import { MapContainer, TileLayer, Marker, useMapEvents } from "react-leaflet";
import "leaflet/dist/leaflet.css";
import L from "leaflet";

const Add = ({ url }) => {
  const navigate = useNavigate();
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
        toast.success("Added Store");
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

  // Component cho việc chọn vị trí trên bản đồ
  const LocationMarker = ({ setLocation }) => {
    const map = useMapEvents({
      click(e) {
        const { lat, lng } = e.latlng;
        setLocation({ lat, lng });
        map.flyTo(e.latlng, map.getZoom());
      },
    });

    return null;
  };

  return (
    <div className="add">
      <div className="cover-left">
        <h2 className="h2-add">Add Store</h2>
        <form className="flex-col" onSubmit={onSubmitHandler}>
          <table className="table">
            <tbody>
              <tr>
                <td colSpan="2">
                  <div className="add-img-upload">
                    <p>Upload Image</p>
                    <label htmlFor="image">
                      <img
                        className="img-upload"
                        src={
                          image
                            ? URL.createObjectURL(image)
                            : assets.upload_area
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
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <p>Store Name</p>
                  <input
                    onChange={onChangeHandler}
                    value={data.storeName}
                    type="text"
                    name="storeName"
                    placeholder="Type here"
                  />
                </td>
                <td>
                  <p>Longitude</p>
                  <input
                    name="longitude"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.longitude}
                    readOnly
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <p>Phone Number</p>
                  <input
                    name="PhoneNumber"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.PhoneNumber}
                  />
                </td>
                <td>
                  <p>Location</p>
                  <input
                    name="Location"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.Location}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <p>Latitude</p>
                  <input
                    name="Latitude"
                    type="text"
                    placeholder="Write content here"
                    onChange={onChangeHandler}
                    value={data.Latitude}
                    readOnly
                  />
                </td>
                <td>
                  <p>Open</p>
                  <input
                    type="time"
                    name="Open"
                    onChange={onChangeHandler}
                    value={data.Open}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <p>Close</p>
                  <input
                    type="time"
                    name="Close"
                    onChange={onChangeHandler}
                    value={data.Close}
                  />
                </td>
                <td>
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
        <p>Pick Location on Map</p>
        {/* <div style={{ height: "300px", width: "100%" }}>
          <MapContainer
            center={[20.5937, 78.9629]} // Tọa độ mặc định
            zoom={13}
            style={{ height: "100%", width: "100%" }}
          >
            <TileLayer
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
              attribution="&copy; <a href='http://osm.org/copyright'>OpenStreetMap</a> contributors"
            />
            <LocationMarker
              setLocation={({ lat, lng }) => {
                setData((prev) => ({
                  ...prev,
                  Latitude: lat,
                  longitude: lng,
                }));
              }}
            />
            {data.Latitude && data.longitude && (
              <Marker
                position={[data.Latitude, data.longitude]}
                icon={
                  new L.Icon({
                    iconUrl:
                      "https://leafletjs.com/examples/custom-icons/leaf-red.png",
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                  })
                }
              />
            )}
          </MapContainer>
        </div> */}
        <div style={{ height: "300px", width: "100%" }}>
          <MapContainer
            center={[16.0544, 108.2022]} // Tọa độ Đà Nẵng, Việt Nam
            zoom={13}
            style={{ height: "100%", width: "100%" }}
          >
            <TileLayer
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
              attribution="&copy; <a href='http://osm.org/copyright'>OpenStreetMap</a> contributors"
            />
            <LocationMarker
              setLocation={({ lat, lng }) => {
                setData((prev) => ({
                  ...prev,
                  Latitude: lat,
                  longitude: lng,
                }));
              }}
            />
            {data.Latitude && data.longitude && (
              <Marker
                position={[data.Latitude, data.longitude]}
                icon={
                  new L.Icon({
                    iconUrl:
                      "https://leafletjs.com/examples/custom-icons/leaf-red.png",
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                  })
                }
              />
            )}
          </MapContainer>
        </div>
      </div>

      <ToastContainer />
    </div>
  );
};

export default Add;
