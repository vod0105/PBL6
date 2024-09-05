import React, { useContext } from "react";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import LoadingSpinner from "../Action/LoadingSpiner";
import { StoreContext } from "../context/StoreContext";
const Home = () => {
  const notifySuccess = () => {
    toast.success("Operation was successful!");
  };
  const { user } = useContext(StoreContext);

  return (
    <div>
      <button onClick={notifySuccess}>Click me</button>
      <ToastContainer />
      <LoadingSpinner />
      <p>Name:{user.name}</p>
    </div>
  );
};

export default Home;
