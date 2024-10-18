
import React, { useState, useEffect } from "react";
import { Modal, Button, Form } from "react-bootstrap";

const CalendarModalEdit = ({
  show,
  handleClose,
  handleUpdate,
  handleDelete,
  event,
}) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [start, setStart] = useState("");
  const [end, setEnd] = useState("");

  useEffect(() => {
    if (event) {
      setTitle(event.title || ""); // Chỉ lấy tên ca làm việc
      setDescription(event.description || "");
      setStart(event.start ? formatDateTimeLocal(event.start) : "");
      setEnd(event.end ? formatDateTimeLocal(event.end) : "");
    }
  }, [event]);

  const formatDateTimeLocal = (date) => {
    const d = new Date(date);
    const pad = (n) => (n < 10 ? "0" + n : n);
    return (
      d.getFullYear() +
      "-" +
      pad(d.getMonth() + 1) +
      "-" +
      pad(d.getDate()) +
      "T" +
      pad(d.getHours()) +
      ":" +
      pad(d.getMinutes())
    );
  };

  const onUpdate = () => {
    if (title && start && end) {
      handleUpdate(event.id, title, description, start, end);
    } else {
      alert("Vui lòng điền đầy đủ thông tin!");
    }
  };

  const onDelete = () => {
    if (window.confirm("Bạn có chắc chắn muốn xóa ca làm việc này?")) {
      handleDelete(event.id);
    }
  };

  return (
    <Modal show={show} onHide={handleClose}>
      <Modal.Header closeButton>
        <Modal.Title>Sửa Ca Làm Việc</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formTitle">
            <Form.Label>Tên Ca</Form.Label>
            <Form.Control
              type="text"
              placeholder="Nhập tên ca làm việc"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formDescription">
            <Form.Label>Mô Tả</Form.Label>
            <Form.Control
              as="textarea"
              rows={3}
              placeholder="Nhập mô tả ca làm việc"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formStart">
            <Form.Label>Bắt Đầu</Form.Label>
            <Form.Control
              type="datetime-local"
              value={start}
              onChange={(e) => setStart(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formEnd">
            <Form.Label>Kết Thúc</Form.Label>
            <Form.Control
              type="datetime-local"
              value={end}
              onChange={(e) => setEnd(e.target.value)}
            />
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="danger" onClick={onDelete}>
          Xóa
        </Button>
        <Button variant="secondary" onClick={handleClose}>
          Đóng
        </Button>
        <Button variant="primary" onClick={onUpdate}>
          Cập Nhật
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default CalendarModalEdit;
