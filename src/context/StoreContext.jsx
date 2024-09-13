import axios from "axios";
import { createContext, useEffect, useState } from "react";
export const StoreContext = createContext(null);

const StoreContextProvider = ({ children }) => {
  const [user, setUser] = useState({ name: "Son" });
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [userData, setUserData] = useState("");
  const [url, setUrl] = useState("http://localhost:8082");
  const [token, setToken] = useState("");
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
  };

  return (
    <StoreContext.Provider value={value}>{children}</StoreContext.Provider>
  );
};
export default StoreContextProvider;
