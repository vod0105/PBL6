// import React, { useEffect } from "react";
// import { BiEdit } from "react-icons/bi";
// import "../styles/Profile.css";
// import { BiBook } from "react-icons/bi";
// const Profile = () => {
//   const course = [
//     {
//       title:'HTML-CSS',
//       duration:'2 Hours',
//       icon:<BiBook/>
//     },
//     {
//       title:'Reacjs',
//       duration:'2 Hours',
//       icon:<BiBook/>
//     },
//     {
//       title:'Laravel',
//       duration:'2 Hours',
//       icon:<BiBook/>
//     },
//   ];



//   //
//   const base64urlDecode = (str) => {
//     // Thay thế các ký tự không hợp lệ
//     str = str.replace(/-/g, '+').replace(/_/g, '/');
//     // Thêm padding nếu cần thiết
//     const pad = str.length % 4;
//     if (pad > 0) {
//       str += '='.repeat(4 - pad);
//     }
//     // Giải mã base64
//     return atob(str);
//   };
  
//   // Hàm lấy payload từ token JWT
//   const getPayloadFromToken = (token) => {
//     const parts = token.split('.');
//     if (parts.length !== 3) {
//       throw new Error('Invalid JWT token');
//     }
//     // Giải mã phần payload
//     const payload = base64urlDecode(parts[1]);
//     // Chuyển đổi JSON thành đối tượng
//     return JSON.parse(payload);
//   };
  
//   // Lấy thông tin người dùng từ token
//   const getUserFromToken = () => {
//     const token = localStorage.getItem('access_token');
//     if (!token) {
//       return null;
//     }
//     try {
//       const payload = getPayloadFromToken(token);
//       return payload.user; // Lấy thông tin người dùng từ payload
//     } catch (error) {
//       console.error('Failed to decode token:', error);
//       return null;
//     }
//   };
  
//   // Ví dụ sử dụng
  
//   useEffect(()=>{
//     const user = getUserFromToken();
//   },[])
//   if (user) {
//     console.log('User ID:', user.id);
//     console.log('User Name:', user.name);
//     console.log('User Email:', user.email);
//   }
//   //

//   return (
//     <div className="profile">
//       <div className="profile--header">
//         <h2 className="header-title">Profile</h2>
//         <div className="edit">
//           <BiEdit className="icon" />
//         </div>
//       </div>
//       <div className="user--profile">
//         <div className="user--detail">
//           <img
//             src="https://th.bing.com/th/id/OIP.k6V8n31jhsNraAUlXqwNgQHaHa?w=512&h=512&rs=1&pid=ImgDetMain"
//             alt=""
//           />
//           <h3 className="username">Trương Ngọc Sơn</h3>
//           <span className="profession">Developer</span>
//         </div>
//         <div className="user-course">
//           {course.map((courses)=>(
//             <div className="courses">
//               <div className="course-detail">
//                 <div className="course-cover">
//                   {courses.icon}
//                 </div>
//                 <div className="course-name">
//                   <h5 className="title">{courses.title}</h5>
//                   <span className="duration"> {courses.duration}</span>
//                 </div>
//               </div>
//               <div className="action">:</div>
//             </div>
//           ))}

          
//           </div>
//         </div>
//       </div>
//     // </div>
//   );
// };

// export default Profile;
import React, { useEffect, useState } from "react";
import { BiEdit, BiBook } from "react-icons/bi";
import "../styles/Profile.css";

const Profile = () => {
  const [user, setUser] = useState(null); // Định nghĩa state để lưu thông tin người dùng

  const course = [
    {
      title: 'HTML-CSS',
      duration: '2 Hours',
      icon: <BiBook />
    },
    {
      title: 'Reactjs',
      duration: '2 Hours',
      icon: <BiBook />
    },
    {
      title: 'Laravel',
      duration: '2 Hours',
      icon: <BiBook />
    },
  ];

  // Hàm giải mã base64url
  // const base64urlDecode = (str) => {
  //   str = str.replace(/-/g, '+').replace(/_/g, '/');
  //   const pad = str.length % 4;
  //   if (pad > 0) {
  //     str += '='.repeat(4 - pad);
  //   }
  //   return atob(str);
  // };

  // // Hàm lấy payload từ token JWT
  // const getPayloadFromToken = (token) => {
  //   const parts = token.split('.');
  //   if (parts.length !== 3) {
  //     throw new Error('Invalid JWT token');
  //   }
  //   const payload = base64urlDecode(parts[1]);
  //   return JSON.parse(payload);
  // };

  // // Lấy thông tin người dùng từ token
  // const getUserFromToken = () => {
  //   const token = localStorage.getItem('access_token');
  //   if (!token) {
  //     return null;
  //   }
  //   try {
  //     const payload = getPayloadFromToken(token);
  //     return payload.user;
  //   } catch (error) {
  //     console.error('Failed to decode token:', error);
  //     return null;
  //   }
  // };

  // // Sử dụng useEffect để lấy thông tin người dùng khi component mount
  // useEffect(() => {
  //   const userInfo = getUserFromToken();
  //   setUser(userInfo);
  //   console.log('userinfo',userInfo);
  // }, []);

  return (
    <div className="profile">
      <div className="profile--header">
        <h2 className="header-title">Profile</h2>
        <div className="edit">
          <BiEdit className="icon" />
        </div>
      </div>
      <div className="user--profile">
        <div className="user--detail">
          <img
            src="https://th.bing.com/th/id/OIP.k6V8n31jhsNraAUlXqwNgQHaHa?w=512&h=512&rs=1&pid=ImgDetMain"
            alt=""
          />
          <h3 className="username">{user ? user.name : "Loading..."}</h3>
          <span className="profession">Developer</span>
        </div>
        <div className="user-course">
          {course.map((courses, index) => (
            <div key={index} className="courses">
              <div className="course-detail">
                <div className="course-cover">
                  {courses.icon}
                </div>
                <div className="course-name">
                  <h5 className="title">{courses.title}</h5>
                  <span className="duration"> {courses.duration}</span>
                </div>
              </div>
              <div className="action">:</div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Profile;
