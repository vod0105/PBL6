import React from "react";
import { BiEdit } from "react-icons/bi";
import "../styles/Profile.css";
import { BiBook } from "react-icons/bi";
const Profile = () => {
  const course = [
    {
      title:'HTML-CSS',
      duration:'2 Hours',
      icon:<BiBook/>
    },
    {
      title:'Reacjs',
      duration:'2 Hours',
      icon:<BiBook/>
    },
    {
      title:'Laravel',
      duration:'2 Hours',
      icon:<BiBook/>
    },
  ];

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
          <h3 className="username">Trương Ngọc Sơn</h3>
          <span className="profession">Developer</span>
        </div>
        <div className="user-course">
          {course.map((courses)=>(
            <div className="courses">
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
    // </div>
  );
};

export default Profile;
