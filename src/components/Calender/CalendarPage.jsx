import "./CalendarPage.css";

import React, { useState, useRef, useEffect, useContext } from "react";
import FullCalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";

import { Button } from "react-bootstrap";
import CalendarModalNew from "./CalendarModalNew";
import CalendarModalEdit from "./CalendarModalEdit";

import { StoreContext } from "../../context/StoreContext";
import axios from "axios";
// Dữ liệu ca làm việc tĩnh
const initialStaffShifts = [
  {
    id: 1,
    staffId: 101,
    staffName: "Nguyễn Văn A",
    title: "Ca sáng",
    start: "2024-04-25T08:00:00",
    end: "2024-04-25T12:00:00",
    description: "Làm việc tại quầy bán hàng",
  },
  {
    id: 2,
    staffId: 102,
    staffName: "Trần Thị B",
    title: "Ca chiều",
    start: "2024-04-25T13:00:00",
    end: "2024-04-25T17:00:00",
    description: "Hỗ trợ khách hàng",
  },
];

// Hàm chuyển đổi dữ liệu ca làm việc thành định dạng FullCalendar
// const convertShiftsToEvents = (shifts) => {
//   // Định nghĩa màu sắc cho mỗi nhân viên
//   const staffColors = {
//     "Nguyễn Văn A": "green",
//     "Trần Thị B": "blue",
//     // Thêm màu cho các nhân viên khác nếu có
//   };

//   return shifts.map((shift) => ({
//     id: shift.id.toString(),
//     title: shift.title, // Chỉ lưu tên ca làm việc
//     start: shift.start,
//     end: shift.end,
//     description: shift.description,
//     extendedProps: {
//       staffName: shift.staffName,
//     },
//     backgroundColor: staffColors[shift.staffName] || "gray", // Màu sắc riêng cho nhân viên
//     borderColor: staffColors[shift.staffName] || "darkgray",
//   }));
// };
const convertShiftsToEvents = (shifts) => {
  const staffColors = {
    "Nguyễn Văn A": "green",
    "Trần Thị B": "blue",
  };

  return shifts.map((shift) => ({
    id: shift.id.toString(),
    title: `${shift.staffId}--${shift.staffName}`, // Thêm tên nhân viên vào tiêu đề
    start: shift.start,
    end: shift.end,
    description: shift.description,
    extendedProps: {
      staffId: shift.staffId,
      staffName: shift.staffName,
    },
    // backgroundColor: staffColors[shift.staffName] || "blue",
    // borderColor: staffColors[shift.staffName] || "darkgray",
    backgroundColor: "blue",
  }));
};

const CalendarPage = () => {
  const { isAuthenticated, setIsAuthenticated, url, setUrl } =
    useContext(StoreContext);
  const [data, setData] = useState([]);
  const [initialStaffShift2, setinitialStaffShift2] = useState([
    {
      id: "",
      staffId: "",
      staffName: "",
      title: "",
      start: "",
      end: "",
      description: "",
    },
  ]);
  // useEffect(() => {
  //   const fetchData = async () => {
  //     try {
  //       const token = localStorage.getItem("access_token");
  //       const headers = {
  //         Authorization: `Bearer ${token}`,
  //         "Content-Type": "application/json",
  //       };
  //       console.log("-1");
  //       const response = await axios.get(`${url}/api/v1/owner/schedule/all`, {
  //         headers,
  //       });
  //       console.log("0");

  //       setTimeout(() => {
  //         setData(response.data.data);
  //         console.log("1");
  //         console.log("data", data);
  //         setinitialStaffShift2((prevShifts) =>
  //           data.map((value) => ({
  //             id: value.id,
  //             staffId: value.staffResponse.id,
  //             staffName: value.staffResponse.employeeName,
  //             title: value.shift,
  //             start: value.startShift,
  //             end: value.endShift,
  //             description: value.staffResponse.department,
  //           }))
  //         );
  //         console.log("2");
  //         console.log("DAta setinitialStaffShift2:", initialStaffShift2);
  //       }, 8000);

  //       console.log("3");

  //       // console.log("DAta setinitialStaffShifts:", initialStaffShifts);
  //     } catch (err) {
  //       // setError(err);
  //     } finally {
  //       // setLoading(false);
  //     }
  //   };

  //   fetchData();
  // }, []);
  // useEffect(() => {
  //   const fetchData = async () => {
  //     try {
  //       const token = localStorage.getItem("access_token");
  //       const headers = {
  //         Authorization: `Bearer ${token}`,
  //         "Content-Type": "application/json",
  //       };
  //       const response = await axios.get(`${url}/api/v1/owner/schedule/all`, {
  //         headers,
  //       });

  //       const fetchedData = response.data.data; // Dữ liệu từ API
  //       // setData(fetchedData);

  //       // Cập nhật initialStaffShift2 bằng cách sử dụng dữ liệu từ API
  //       const updatedShifts = fetchedData.map((value) => ({
  //         id: value.id,
  //         staffId: value.staffResponse.id,
  //         staffName: value.staffResponse.employeeName,
  //         title: value.shift,
  //         start: value.startShift,
  //         end: value.endShift,
  //         description: value.staffResponse.department,
  //       }));

  //       setinitialStaffShift2(updatedShifts);

  //       // Sau khi set initialStaffShift2, cập nhật lại events để hiển thị trên FullCalendar
  //       setEvents(convertShiftsToEvents(updatedShifts));

  //       console.log("Dữ liệu từ API:", fetchedData);
  //       console.log("Dữ liệu từ setinitialStaffShift2:", initialStaffShift2);
  //     } catch (err) {
  //       console.error("Lỗi khi gọi API:", err);
  //     }
  //   };

  //   fetchData();
  // }, [url]);
  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        };
        const response = await axios.get(`${url}/api/v1/owner/schedule/all`, {
          headers,
        });

        const fetchedData = response.data.data; 

       
        const updatedShifts = fetchedData.map((value) => ({
          id: value.id,
          staffId: value.staffResponse.id,
          staffName: value.staffResponse.employeeName,
          title: value.shift,
          start: value.startShift,
          end: value.endShift,
          description: value.staffResponse.department,
        }));

  
        setinitialStaffShift2(updatedShifts);
        setEvents(convertShiftsToEvents(updatedShifts));

        console.log("Dữ liệu từ API:", fetchedData);
        console.log("Dữ liệu từ setinitialStaffShift2:", updatedShifts); 
      } catch (err) {
        console.error("Lỗi khi gọi API:", err);
      }
    };

    fetchData();
  }, [url]);

  const [events, setEvents] = useState(
    convertShiftsToEvents(initialStaffShifts)
  );
  const [showNewModal, setShowNewModal] = useState(false);
  const [showEditModal, setShowEditModal] = useState(false);
  const [selectedEvent, setSelectedEvent] = useState(null);

  const calendarRef = useRef(null);

  const handleDateClick = (arg) => {
    setSelectedEvent({ date: arg.date });
    setShowNewModal(true);
  };

  const handleEventClick = (clickInfo) => {
    setSelectedEvent({
      id: clickInfo.event.id,
      staffName: clickInfo.event.extendedProps.staffName || "",
      title: clickInfo.event.title || "",
      start: clickInfo.event.start,
      end: clickInfo.event.end,
      description: clickInfo.event.extendedProps.description || "",
    });
    setShowEditModal(true);
  };

  const handleAddEvent = (title, description, start, end) => {
    const newId =
      events.length > 0
        ? Math.max(...events.map((event) => parseInt(event.id))) + 1
        : 1;
    const newEvent = {
      id: newId.toString(),
      title, // Chỉ lưu tên ca làm việc
      start,
      end,
      description,
      extendedProps: {
        staffName: selectedEvent.staffName || "Nhân viên",
      },
      backgroundColor: "green", // Bạn có thể tùy chỉnh hoặc tự động gán màu
      borderColor: "darkgreen",
    };
    setEvents([...events, newEvent]);

    console.log("new evernt", newEvent);
    setShowNewModal(false);
  };

  const handleUpdateEvent = (id, title, description, start, end) => {
    const updatedEvents = events.map((event) =>
      event.id === id
        ? {
            ...event,
            title, // Chỉ lưu tên ca làm việc
            description,
            start,
            end,
            extendedProps: {
              staffName: selectedEvent.staffName || "Nhân viên",
            },
          }
        : event
    );
    setEvents(updatedEvents);
    setShowEditModal(false);
  };

  const handleDeleteEvent = (id) => {
    const updatedEvents = events.filter((event) => event.id !== id);
    setEvents(updatedEvents);
    setShowEditModal(false);
  };

  const switchToMonthView = () => {
    let calendarApi = calendarRef.current.getApi();
    calendarApi.changeView("dayGridMonth");
  };

  const switchToDayView = () => {
    let calendarApi = calendarRef.current.getApi();
    calendarApi.changeView("timeGridDay");
  };

  return (
    <div className="x_content">
      {/* Legend để phân biệt màu sắc của các nhân viên */}
      <div className="legend" style={{ marginBottom: "20px" }}>
        <span
          style={{
            display: "inline-block",
            width: "12px",
            height: "12px",
            backgroundColor: "green",
            marginRight: "5px",
          }}
        ></span>{" "}
        Nguyễn Văn A
        <span
          style={{
            display: "inline-block",
            width: "12px",
            height: "12px",
            backgroundColor: "blue",
            marginLeft: "15px",
            marginRight: "5px",
          }}
        ></span>{" "}
        Trần Thị B{/* Thêm các nhân viên khác ở đây */}
      </div>

      <div className="calendar-controls" style={{ marginBottom: "20px" }}>
        <Button
          variant="primary"
          onClick={switchToMonthView}
          style={{ marginRight: "10px" }}
        >
          Chuyển sang View Tháng
        </Button>
        <Button variant="secondary" onClick={switchToDayView}>
          Chuyển sang View Ngày
        </Button>
      </div>

      <FullCalendar
        ref={calendarRef}
        plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
        initialView={"timeGridDay"}
        selectable={true}
        editable={true}
        events={events}
        dateClick={handleDateClick}
        eventClick={handleEventClick}
        height={600}
      />

      <CalendarModalNew
        show={showNewModal}
        handleClose={() => setShowNewModal(false)}
        handleSave={handleAddEvent}
      />

      <CalendarModalEdit
        show={showEditModal}
        handleClose={() => setShowEditModal(false)}
        handleUpdate={handleUpdateEvent}
        handleDelete={handleDeleteEvent} // Truyền hàm xóa sự kiện
        event={selectedEvent}
      />
    </div>
  );
};

export default CalendarPage;
