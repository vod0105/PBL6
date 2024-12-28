import axios from "axios";
import React, { useEffect, useState, useRef } from "react";

// Tải âm thanh
const notificationSound = new Audio("/sound/tingting.mp3");

const SoundNotification = ({ url }) => {
  const [apiResult, setApiResult] = useState(false);
  const vlcurrent = useRef(0);

  const mess = useRef("");

  useEffect(() => {
    const checkApi = async () => {
      try {
        const tk = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${tk}`,
          "Content-Type": "application/json",
        };
        const response = await axios.get(`${url}/api/v1/owner/announce`, {
          headers,
        });
        const newCount = response.data.data.length;
        console.log("newcount: ", newCount);

        mess.current = response.data.data[newCount - 1].content;
        console.log("mes", mess.current);

        if (newCount > vlcurrent.current) {
          vlcurrent.current = newCount;
          setApiResult(true);
          playSound();
        }
      } catch (error) {
        console.error("Lỗi khi gọi API:", error);
      }
    };

    const playSound = () => {
      const speech = new SpeechSynthesisUtterance(mess.current);
      speech.lang = "vi-VN";
      window.speechSynthesis.speak(speech);
      notificationSound.play().catch((error) => {
        console.error("Lỗi phát âm thanh:", error);
      });
    };

    const intervalId = setInterval(checkApi, 3000);

    return () => clearInterval(intervalId);
  }, []);

  return null;
};

export default SoundNotification;
