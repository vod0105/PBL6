import React, { useState } from 'react';
import axios from 'axios';
import { MapContainer, TileLayer, Polyline } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import polyline from 'polyline'; // Import polyline library

const RouteMap = () => {
  const [route, setRoute] = useState(null);
  const [distance, setDistance] = useState(null);
  const [error, setError] = useState(null);
  const apiKey = '5b3ce3597851110001cf6248d480712f52d0466d8d71a3927b194e84Y'; // Replace with your actual API key

  // geometry -> 2 điểm 
  const decodePolyline = (encoded) => {
    const decodedCoords = polyline.decode(encoded);
    // Chuyển đổi [lng, lat] sang [lat, lng]
    return decodedCoords.map(coord => ({ lat: coord[0], lng: coord[1] }));
  };

  const fetchRoute = async () => {
    const start = [108.2207, 16.0471]; // Đà Nẵng
    const end = [107.5804, 16.4637];   // Huế

    // const end = [105.9009, 18.3340]; // Hà Tĩnh
    // const start = [105.9250, 18.29740]; // THPT Cẩm Bình
    // const end = [105.9233894, 18.2973655]; // Hải Thắng

    try {
      const response = await axios.post(
        `https://api.openrouteservice.org/v2/directions/driving-car`,
        {
          coordinates: [start, end],
          format: 'geojson',
        },
        {
          headers: {
            Authorization: apiKey,
            'Content-Type': 'application/json',
          },
        }
      );

      console.log('>>> check res: ', response);

      // Extract and display distance from API response
      if (
        response.data &&
        response.data.routes &&
        response.data.routes[0]?.segments &&
        response.data.routes[0].segments[0]?.distance &&
        response.data.routes[0].geometry
      ) {
        const routeDistance = response.data.routes[0].segments[0].distance;
        setDistance((routeDistance / 1000).toFixed(2)); // Convert to km and format

        // Get route geometry (assuming it's a polyline string)
        // const geometry = response.data.routes[0].geometry;
        // Convert geometry -> [lng, lat] to [lat, lng]
        const decodedPath = decodePolyline(response.data.routes[0].geometry);
        console.log('>>> geometry: ', decodedPath);
        setRoute(decodedPath);
        setError(null);
      } else {
        setError("Unexpected API response format");
      }
    } catch (err) {
      setError("Unable to fetch route: " + err.message);
      console.error(err);
    }
  };

  return (
    <div>
      <button onClick={fetchRoute}>Tính toán lộ trình từ Đà Nẵng đến Hà Tĩnh</button>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      {distance && (
        <p>Khoảng cách từ Đà Nẵng đến Hà Tĩnh: {distance} km</p> // Display distance in km
      )}
      <MapContainer center={[16.2554, 107.9006]} zoom={9} style={{ height: '500px', width: '100%' }}>
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        />
        {route && (
          <Polyline positions={route} color="blue" />
        )}
      </MapContainer>
    </div>
  );
};

export default RouteMap;
