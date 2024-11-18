import "./CalendarPage.css";
import React, { useState, useRef, useEffect, useContext } from "react";
import FullCalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import { Button, Form } from "react-bootstrap"; // Thêm Form từ react-bootstrap
import CalendarModalNew from "./CalendarModalNew";
import CalendarModalEdit from "./CalendarModalEdit";
import { StoreContext } from "../../context/StoreContext";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import SoundNotification from "../Notify/Notify";

const convertShiftsToEvents = (shifts) => {
  const staffColors = {
    1: "green",
    2: "blue",
    3: "red",
    4: "purple",
    5: "orange",
    6: "yellow",
    7: "cyan",
    8: "magenta",
    9: "lime",
    10: "teal",
    11: "pink",
    12: "brown",
    13: "gray",
    14: "black",
    15: "maroon",
    16: "navy",
    17: "olive",
    18: "violet",
    19: "gold",
    20: "silver",
  };

  return shifts.map((shift) => ({
    id: shift.id.toString(),
    title: `${shift.staffId}--${shift.staffName}:${shift.title}/${shift.id}`,
    start: shift.start,
    end: shift.end,
    description: shift.description,
    extendedProps: {
      staffId: shift.staffId,
      staffName: shift.staffName,
    },
    backgroundColor: staffColors[shift.staffId] || "gray",
    borderColor: staffColors[shift.staffId] || "darkgray",
  }));
};

const CalendarPage = () => {
  const { isAuthenticated, setIsAuthenticated, url, setUrl } =
    useContext(StoreContext);
  const [data, setData] = useState([]);
  const [initialStaffShift2, setinitialStaffShift2] = useState([]);
  const [events, setEvents] = useState([]);
  const [showNewModal, setShowNewModal] = useState(false);
  const [showEditModal, setShowEditModal] = useState(false);
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [selectedStaffId, setSelectedStaffId] = useState(""); // Trạng thái nhân viên được chọn
  const calendarRef = useRef(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        };
        const response = await axios.get(`${url}/api/v1/owner/schedule/store`, {
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
      } catch (err) {
        console.error("Lỗi khi gọi API:", err);
      }
    };

    fetchData();
  }, [url]);

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
      title,
      start,
      end,
      description,
      extendedProps: { staffName: selectedEvent.staffName || "Nhân viên" },
      backgroundColor: "green",
      borderColor: "darkgreen",
    };
    setEvents([...events, newEvent]);
    setShowNewModal(false);
  };

  const handleUpdateEvent = (id, title, description, start, end) => {
    const updatedEvents = events.map((event) =>
      event.id === id
        ? {
            ...event,
            title,
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

  const handleDeleteEvent = async (id) => {
    const updatedEvents = events.filter((event) => event.id !== id);
    try {
      const token = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };
      const response = await axios.delete(
        `${url}/api/v1/owner/schedule/delete/${id}`,
        { headers }
      );

      if (response.data.success) {
        toast.success("Delete Shift Successful");
      } else {
        toast.error("Lỗi khi xóa!");
      }
    } catch (err) {
      console.error("Lỗi khi gọi API:", err);
    }
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
      {/* Dropdown để chọn nhân viên */}
      <SoundNotification url={url} />

      <div className="calendar-controls" style={{ marginBottom: "20px" }}>
        <div>
          <Button
            variant="primary"
            onClick={switchToMonthView}
            style={{ marginRight: "10px" }}
            className="viewmonth"
          >
            Chuyển sang View Tháng
          </Button>
          <Button
            variant="secondary"
            className="viewday"
            onClick={switchToDayView}
          >
            Chuyển sang View Ngày
          </Button>
        </div>
        <Form.Group controlId="staffSelect" className="selectStaff">
          <Form.Label className="selectStaff">Chọn nhân viên</Form.Label>
          {/* <Form.Control
            as="select"
            value={selectedStaffId}
            onChange={(e) => setSelectedStaffId(e.target.value)}
          >
            <option value="">Tất cả nhân viên</option>
            {initialStaffShift2.map((shift) => (
              <option key={shift.staffId} value={shift.staffId}>
                {shift.staffName}
              </option>
            ))}
          </Form.Control> */}
          <Form.Control
            as="select"
            value={selectedStaffId}
            onChange={(e) => setSelectedStaffId(e.target.value)}
          >
            <option value="">Tất cả nhân viên</option>
            {Array.from(
              initialStaffShift2.reduce((unique, shift) => {
                if (!unique.has(shift.staffId)) {
                  unique.set(shift.staffId, shift.staffName);
                }
                return unique;
              }, new Map())
            ).map(([staffId, staffName]) => (
              <option key={staffId} value={staffId}>
                {staffName}
              </option>
            ))}
          </Form.Control>
        </Form.Group>
      </div>

      <FullCalendar
        ref={calendarRef}
        plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
        initialView={"timeGridDay"}
        selectable={true}
        editable={true}
        events={
          selectedStaffId
            ? events.filter(
                (event) =>
                  event.extendedProps.staffId === Number(selectedStaffId)
              ) // Lọc sự kiện theo nhân viên được chọn
            : events
        }
        dateClick={handleDateClick}
        eventClick={handleEventClick}
        height={550}
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
        handleDelete={handleDeleteEvent}
        event={selectedEvent}
      />
      <ToastContainer />
    </div>
  );
};

export default CalendarPage;
// import "./CalendarPage.css";
// import React, { useState, useRef, useEffect, useContext } from "react";
// import FullCalendar from "@fullcalendar/react";
// import dayGridPlugin from "@fullcalendar/daygrid";
// import timeGridPlugin from "@fullcalendar/timegrid";
// import interactionPlugin from "@fullcalendar/interaction";
// import { Button, Form } from "react-bootstrap"; // Thêm Form từ react-bootstrap
// import CalendarModalNew from "./CalendarModalNew";
// import CalendarModalEdit from "./CalendarModalEdit";
// import { StoreContext } from "../../context/StoreContext";
// import axios from "axios";
// import { ToastContainer, toast } from "react-toastify";

// const convertShiftsToEvents = (shifts) => {
//   const staffColors = {
//     1: "green",
//     2: "blue",
//     3: "red",
//     4: "purple",
//     5: "orange",
//     6: "yellow",
//     7: "cyan",
//     8: "magenta",
//     9: "lime",
//     10: "teal",
//     11: "pink",
//     12: "brown",
//     13: "gray",
//     14: "black",
//     15: "maroon",
//     16: "navy",
//     17: "olive",
//     18: "violet",
//     19: "gold",
//     20: "silver",
//   };

//   return shifts.map((shift) => ({
//     id: shift.id.toString(),
//     title: `${shift.staffId}--${shift.staffName}:${shift.title}/${shift.id}`,
//     start: shift.start,
//     end: shift.end,
//     description: shift.description,
//     extendedProps: {
//       staffId: shift.staffId,
//       staffName: shift.staffName,
//     },
//     backgroundColor: staffColors[shift.staffId] || "gray",
//     borderColor: staffColors[shift.staffId] || "darkgray",
//   }));
// };

// // Hàm để lọc danh sách nhân viên duy nhất
// const getUniqueStaff = (shifts) => {
//   const staffMap = {};
//   shifts.forEach((shift) => {
//     if (!staffMap[shift.staffId]) {
//       staffMap[shift.staffId] = shift.staffName;
//     }
//   });
//   return Object.entries(staffMap).map(([staffId, staffName]) => ({
//     staffId,
//     staffName,
//   }));
// };

// const CalendarPage = () => {
//   const { isAuthenticated, setIsAuthenticated, url, setUrl } =
//     useContext(StoreContext);
//   const [data, setData] = useState([]);
//   const [initialStaffShift2, setinitialStaffShift2] = useState([]);
//   const [events, setEvents] = useState([]);
//   const [showNewModal, setShowNewModal] = useState(false);
//   const [showEditModal, setShowEditModal] = useState(false);
//   const [selectedEvent, setSelectedEvent] = useState(null);
//   const [selectedStaffId, setSelectedStaffId] = useState(""); // Trạng thái nhân viên được chọn
//   const calendarRef = useRef(null);

//   useEffect(() => {
//     const fetchData = async () => {
//       try {
//         const token = localStorage.getItem("access_token");
//         const headers = {
//           Authorization: `Bearer ${token}`,
//           "Content-Type": "application/json",
//         };
//         const response = await axios.get(
//           `${url}/api/v1/owner/schedule/store/35`,
//           { headers }
//         );
//         const fetchedData = response.data.data;

//         const updatedShifts = fetchedData.map((value) => ({
//           id: value.id,
//           staffId: value.staffResponse.id,
//           staffName: value.staffResponse.employeeName,
//           title: value.shift,
//           start: value.startShift,
//           end: value.endShift,
//           description: value.staffResponse.department,
//         }));

//         setinitialStaffShift2(updatedShifts);
//         setEvents(convertShiftsToEvents(updatedShifts));
//       } catch (err) {
//         console.error("Lỗi khi gọi API:", err);
//       }
//     };

//     fetchData();
//   }, [url]);

//   const handleDateClick = (arg) => {
//     setSelectedEvent({ date: arg.date });
//     setShowNewModal(true);
//   };

//   const handleEventClick = (clickInfo) => {
//     setSelectedEvent({
//       id: clickInfo.event.id,
//       staffName: clickInfo.event.extendedProps.staffName || "",
//       title: clickInfo.event.title || "",
//       start: clickInfo.event.start,
//       end: clickInfo.event.end,
//       description: clickInfo.event.extendedProps.description || "",
//     });
//     setShowEditModal(true);
//   };

//   const handleAddEvent = (title, description, start, end) => {
//     const newId =
//       events.length > 0
//         ? Math.max(...events.map((event) => parseInt(event.id))) + 1
//         : 1;
//     const newEvent = {
//       id: newId.toString(),
//       title,
//       start,
//       end,
//       description,
//       extendedProps: { staffName: selectedEvent.staffName || "Nhân viên" },
//       backgroundColor: "green",
//       borderColor: "darkgreen",
//     };
//     setEvents([...events, newEvent]);
//     setShowNewModal(false);
//   };

//   const handleUpdateEvent = (id, title, description, start, end) => {
//     const updatedEvents = events.map((event) =>
//       event.id === id
//         ? {
//             ...event,
//             title,
//             description,
//             start,
//             end,
//             extendedProps: {
//               staffName: selectedEvent.staffName || "Nhân viên",
//             },
//           }
//         : event
//     );
//     setEvents(updatedEvents);
//     setShowEditModal(false);
//   };

//   const handleDeleteEvent = async (id) => {
//     const updatedEvents = events.filter((event) => event.id !== id);
//     try {
//       const token = localStorage.getItem("access_token");
//       const headers = {
//         Authorization: `Bearer ${token}`,
//         "Content-Type": "application/json",
//       };
//       const response = await axios.delete(
//         `${url}/api/v1/owner/schedule/delete/${id}`,
//         { headers }
//       );

//       if (response.data.success) {
//         toast.success("Delete Shift Successful");
//       } else {
//         toast.error("Lỗi khi xóa!");
//       }
//     } catch (err) {
//       console.error("Lỗi khi gọi API:", err);
//     }
//     setEvents(updatedEvents);
//     setShowEditModal(false);
//   };

//   const switchToMonthView = () => {
//     let calendarApi = calendarRef.current.getApi();
//     calendarApi.changeView("dayGridMonth");
//   };

//   const switchToDayView = () => {
//     let calendarApi = calendarRef.current.getApi();
//     calendarApi.changeView("timeGridDay");
//   };

//   return (
//     <div className="x_content">
//       {/* Dropdown để chọn nhân viên */}

//       <div className="calendar-controls" style={{ marginBottom: "20px" }}>
//         <div>
//           <Button
//             variant="primary"
//             onClick={switchToMonthView}
//             style={{ marginRight: "10px" }}
//             className="viewmonth"
//           >
//             Chuyển sang View Tháng
//           </Button>
//           <Button
//             variant="secondary"
//             className="viewday"
//             onClick={switchToDayView}
//           >
//             Chuyển sang View Ngày
//           </Button>
//         </div>
//         <Form.Group controlId="staffSelect" className="selectStaff">
//           <Form.Label className="selectStaff">Chọn nhân viên</Form.Label>
//           <Form.Control
//             as="select"
//             value={selectedStaffId}
//             onChange={(e) => setSelectedStaffId(e.target.value)}
//           >
//             <option value="">Tất cả nhân viên</option>
//             {getUniqueStaff(initialStaffShift2).map((shift) => (
//               <option key={shift.staffId} value={shift.staffId}>
//                 {shift.staffName}
//               </option>
//             ))}
//           </Form.Control>
//         </Form.Group>
//       </div>

//       <FullCalendar
//         ref={calendarRef}
//         plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
//         initialView={"timeGridDay"}
//         selectable={true}
//         editable={true}
//         events={
//           selectedStaffId
//             ? events.filter(
//                 (event) =>
//                   event.extendedProps.staffId === Number(selectedStaffId)
//               ) // Lọc sự kiện theo nhân viên được chọn
//             : events
//         }
//         dateClick={handleDateClick}
//         eventClick={handleEventClick}
//         height={580}
//       />

//       <CalendarModalNew
//         show={showNewModal}
//         handleClose={() => setShowNewModal(false)}
//         handleSave={handleAddEvent}
//       />

//       <CalendarModalEdit
//         show={showEditModal}
//         handleClose={() => setShowEditModal(false)}
//         handleSave={handleUpdateEvent}
//         handleDelete={handleDeleteEvent}
//         selectedEvent={selectedEvent}
//       />
//       <ToastContainer />
//     </div>
//   );
// };

// export default CalendarPage;
