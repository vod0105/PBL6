import React from 'react'
import { ToastContainer,toast } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css';
const Toastify = () => {
  const notify= ()=>{
    toast.success("ok");
  }
  return (
    <div>
      <button onClick={notify}>clickNeAhihi</button>
      <ToastContainer/>
    </div>
  )
}

export default Toastify
