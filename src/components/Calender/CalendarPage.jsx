import "./CalendarPage.css";

import React, { useState, useRef } from "react";
import FullCalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";

import { Button } from "react-bootstrap";
import CalendarModalNew from "./CalendarModalNew";
import CalendarModalEdit from "./CalendarModalEdit";

const CalendarPage = () => {
  const [events, setEvents] = useState([]);
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
      title: clickInfo.event.title,
      start: clickInfo.event.start,
      description: clickInfo.event.extendedProps.description,
    });
    setShowEditModal(true);
  };

  const handleAddEvent = (title, description) => {
    setEvents([
      ...events,
      {
        id: Date.now().toString(), // Tạo ID cho sự kiện mới
        title,
        start: selectedEvent.date,
        description,
      },
    ]);
    setShowNewModal(false);
  };

  const handleUpdateEvent = (id, title, description) => {
    setEvents(
      events.map((event) =>
        event.id === id ? { ...event, title, description } : event
      )
    );
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
        eventColor={"blue"}
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
        event={selectedEvent}
      />
    </div>
  );
};

export default CalendarPage;
