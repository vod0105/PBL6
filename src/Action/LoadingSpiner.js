// LoadingSpinner.js
import React from 'react';
import ClipLoader from 'react-spinners/ClipLoader';

function LoadingSpinner() {
  return (
    <div className="spinner-container">
      <ClipLoader color="#36d7b7" size={50} />
    </div>
  );
}

export default LoadingSpinner;
