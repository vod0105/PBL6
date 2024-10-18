
import React, { useState } from "react";
import { Modal, Button, Form } from "react-bootstrap";

const CalendarModalNew = ({ show, handleClose, handleSave }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [start, setStart] = useState("");
  const [end, setEnd] = useState("");

  const onSave = () => {
    if (title && start && end) {
      handleSave(title, description, start, end);
      setTitle("");
      setDescription("");
      setStart("");
      setEnd("");
    } else {
      alert("Vui lòng điền đầy đủ thông tin!");
    }
  };

  return (
    <Modal show={show} onHide={handleClose}>
      <Modal.Header closeButton>
        <Modal.Title>Thêm Ca Làm Việc Mới</Modal.Title>
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
        <Button variant="secondary" onClick={handleClose}>
          Đóng
        </Button>
        <Button variant="primary" onClick={onSave}>
          Lưu
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default CalendarModalNew;
