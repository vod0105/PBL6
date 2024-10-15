import React, { useState } from "react";
import { Modal, Button, Form } from "react-bootstrap";

const CalendarModalNew = ({ show, handleClose, handleSave }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");

  const onSave = () => {
    if (handleSave && typeof handleSave === "function") {
      handleSave(title, description);
      setTitle("");
      setDescription("");
    } else {
      console.error("handleSave is not a function1");
    }
  };

  return (
    <Modal show={show} onHide={handleClose}>
      <Modal.Header closeButton>
        <Modal.Title>Thêm Sự Kiện Mới</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formEventTitle">
            <Form.Label>Tên Sự Kiện</Form.Label>
            <Form.Control
              type="text"
              placeholder="Nhập tên sự kiện"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formEventDescription">
            <Form.Label>Mô Tả</Form.Label>
            <Form.Control
              as="textarea"
              rows={3}
              placeholder="Nhập mô tả"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
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
