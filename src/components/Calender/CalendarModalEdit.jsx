import React, { useState, useEffect, useContext } from "react";
import { Modal, Button, Form } from "react-bootstrap";
import axios from "axios";
import { StoreContext } from "../../context/StoreContext";
import { toast, ToastContainer } from "react-toastify";

const CalendarModalEdit = ({
  show,
  handleClose,
  handleUpdate,
  handleDelete,
  event,
}) => {
  const [title, setTitle] = useState("");
  const [shift, setShift] = useState("");
  const [description, setDescription] = useState("");
  const [start, setStart] = useState("");
  const [end, setEnd] = useState("");
  const { url } = useContext(StoreContext);
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

  const onUpdate = async () => {
    if (title && start && end) {
      const id = title.split("/")[1];
      const staffId = title.split("--")[0];
      const token = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };

      const postData = {
        shift: shift,
        startShift: start,
        endShift: end,
        date: end,
        staffId: staffId,
      };
      console.log("postdata", postData);
      console.log(`${url}/api/v1/owner/schedule/update/${id}`);
      try {
        const formData = new FormData();
        formData.append("shift", postData.shift);
        formData.append("startShift", postData.startShift);
        formData.append("endShift", postData.endShift);
        formData.append("date", postData.date);
        formData.append("staffId", postData.staffId);

        const response = await axios.put(
          `${url}/api/v1/owner/schedule/update/${id}`, // Đường dẫn API để thêm ca làm việc
          formData,
          { headers }
        );
        toast.success("Update Shift Successful");
        console.log("Sửa ca làm việc thành công:", response.data);

        setTitle("");
        setDescription("");
        setStart("");
        setEnd("");
        setShift("");

        handleClose();
        setTimeout(() => {
          window.location.reload();
        }, 1500);

        // window.location.href = "http://localhost:3000/owner/calender";
      } catch (error) {
        console.error("Lỗi khi thêm ca làm việc:", error);
        alert("Đã xảy ra lỗi khi thêm ca làm việc.");
      }
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
            <Form.Label>ID</Form.Label>
            <Form.Control
              type="text"
              placeholder="Nhập tên ca làm việc"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              readOnly
            />
          </Form.Group>

          <Form.Group controlId="formTitle">
            <Form.Label>Tên Ca</Form.Label>
            <Form.Select
              value={shift}
              onChange={(e) => setShift(e.target.value)}
            >
              <option value="">Chọn tên ca</option>
              <option value="Ca Sáng">Ca Sáng</option>
              <option value="Ca Chiều">Ca Chiều</option>
              <option value="Ca Tối">Ca Tối</option>
              {/* Thêm các lựa chọn khác nếu cần */}
            </Form.Select>
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
