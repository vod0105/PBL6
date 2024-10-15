// src/components/Modals/CalendarModalNew.js
import React, { useState } from "react";
import { Modal, Button, Form } from "react-bootstrap";

const CalendarModalEdit = ({ show, handleClose, handleSave }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");

  const onSave = () => {
    handleSave(title, description);
    setTitle("");
    setDescription("");
  };

  return (
    <Modal show={show} onHide={handleClose}>
      <Modal.Header closeButton>
        <Modal.Title>Update</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formTitle">
            <Form.Label>Title</Form.Label>
            <Form.Control
              type="text"
              placeholder="Enter title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formDescription" className="mt-3">
            <Form.Label>Description</Form.Label>
            <Form.Control
              as="textarea"
              rows={3}
              placeholder="Enter description"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
            />
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleClose}>
          Close
        </Button>
        <Button variant="primary" onClick={onSave}>
          Save changes
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default CalendarModalEdit;
