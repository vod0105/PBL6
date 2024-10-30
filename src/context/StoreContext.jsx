import axios from "axios";
import { createContext, useEffect, useState } from "react";
export const StoreContext = createContext(null);

const StoreContextProvider = ({ children }) => {
  const [user, setUser] = useState({ name: "Son" });
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [userData, setUserData] = useState("");
  const [url, setUrl] = useState("http://localhost:8888");
  const [token, setToken] = useState("");
  const [stores, setStores] = useState([]);
  const[idU,setIdU] = useState(1); 
  const value = {
    user,
    setUser,
    isAuthenticated,
    setIsAuthenticated,
    userData,
    setUserData,
    url,
    setUrl,
    token,
    setToken,
    stores,
    setStores,
    idU,
  };

  useEffect(() => {
    console.log("stores o context: ", stores);
  },stores)
//   useEffect(() => {
//     if(isAuthenticated)
//     fetchAllStores();
//   },[isAuthenticated])

//   const fetchAllStores = async () => {
//     try {
//         const res = await axios.get(`${url}/api/chats/users-chat`, {
//             headers: {
//                 'Authorization': `Bearer ${token}`  // Thêm token vào header
//             }
//         });
//         console.log("dl trả về", res);
//         if (res.EC === 0) {
//             const updatedStores = res.DT.map(store => ({
//                 ...store,
//                 online: false, // Giá trị mặc định cho thuộc tính `online`
//                 is_online:true
//             }));
//             setStores(updatedStores);
//         }
//     } catch (error) {
//         console.error("Lỗi khi lấy dữ liệu cửa hàng:", error);
//     }
// };

  return (
    <StoreContext.Provider value={value}>{children}</StoreContext.Provider>
  );
};
export default StoreContextProvider;
