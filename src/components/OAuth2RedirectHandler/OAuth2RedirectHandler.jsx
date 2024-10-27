import React, { useEffect } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { getUserAccount } from '../../redux/actions/authActions';


const OAuth2RedirectHandler = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const dispatch = useDispatch();
  useEffect(() => {
    console.log('Current URL:', window.location.href); // Kiểm tra URL đầy đủ
    const params = new URLSearchParams(location.search);
    const token = params.get('token');
    // console.log("params", params);

    if (token) {
      localStorage.setItem('token', token);
      dispatch(getUserAccount());
      navigate('/');
      // alert('GG thành công -> Homepage');
    } else {
      // navigate('/login');
      // alert('GG không thành công -> Login')
    }
  }, [navigate, location]);


  return <p>Redirecting...</p>;
};

export default OAuth2RedirectHandler;
