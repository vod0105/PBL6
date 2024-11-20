import React, { useState, useEffect } from 'react';
import MoonLoader from 'react-spinners/MoonLoader';

const Loading = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setLoading(false);
    }, 15000); // Giả lập dữ liệu được tải trong 3 giây
  }, []);

  return (
    <div>
      {loading ? (
        <div className="spinner">
          <MoonLoader size={50} color={"#ff0000"} loading={loading} />
        </div>
      ) : (
        <div>
          <h1>Dữ liệu đã tải xong</h1>
        </div>
      )}
    </div>
  );
};

export default Loading;
