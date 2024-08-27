import React from "react";
import ContentHeader from "./ContentHeader";
import "../styles/Content.css";
import Profile from "./Profile";

const Content = () => {
  return (
    <div className="content">
      <ContentHeader />
      <div className="test">
        <div className="left-content">
          {/* Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni labore
          earum animi temporibus, accusantium totam impedit neque! Culpa,
          sapiente quod dolor eum non eius natus odio. Tempore beatae ipsum
          officia! */}
        </div>
        <Profile />
      </div>
    </div>
  );
};

export default Content;
