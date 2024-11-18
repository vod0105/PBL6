import React, { useState, useEffect, useContext } from "react";
import { Modal, Button, Form } from "react-bootstrap";
import axios from "axios";
import { StoreContext } from "../../context/StoreContext";
import { toast } from "react-toastify";

const CalendarModalNew = ({ show, handleClose, handleSave }) => {
  const { url } = useContext(StoreContext);

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [start, setStart] = useState("");
  const [end, setEnd] = useState("");
  const [staffId, setStaffId] = useState("");
  const [staffName, setStaffName] = useState("");
  const [staffList, setStaffList] = useState([]);

  // Gọi API để lấy danh sách nhân viên
  useEffect(() => {
    const fetchStaffList = async () => {
      try {
        const token = localStorage.getItem("access_token");
        const headers = {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        };
        const response = await axios.get(
          `${url}/api/v1/owner/staff/store`,
          { headers }
        );
        console.log("Staff List Response:", response.data.data);
        setStaffList(
          Array.isArray(response.data.data) ? response.data.data : []
        );
      } catch (err) {
        console.error("Lỗi khi lấy danh sách nhân viên:", err);
        setStaffList([]);
      }
    };

    fetchStaffList();
  }, []);

  const onSave = async () => {
    if (title && start && end && staffId) {
      handleSave(title, description, start, end);
      const token = localStorage.getItem("access_token");
      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      };

      const postData = {
        title: title,
        description: description,
        start: start,
        end: end,
        staffId: staffId,
        staffName: staffName,
      };
      console.log("postdata", postData);

      try {
        console.log("Post DAta:", postData);
        const formData = new FormData();
        formData.append("shift", postData.title);

        formData.append("startShift", postData.start);
        formData.append("endShift", postData.end);
        formData.append("date", postData.end);
        formData.append("staffId", postData.staffId);

        const response = await axios.post(
          `${url}/api/v1/owner/schedule/create`, // Đường dẫn API để thêm ca làm việc
          formData,
          { headers }
        );

        console.log("Thêm ca làm việc thành công:", response.data);

        setTitle("");
        setDescription("");
        setStart("");
        setEnd("");
        setStaffId("");
        setStaffName("");
        handleClose();
        toast.success("Add Employee To Shift Successfull!");
  
      } catch (error) {
        console.error("Lỗi khi thêm ca làm việc:", error);
        alert("Đã xảy ra lỗi khi thêm ca làm việc.");
      }
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
          <Form.Group controlId="Staff">
            <Form.Label>Nhân Viên</Form.Label>
            <Form.Control
              as="select"
              value={staffId}
              onChange={(e) => {
                const selectedStaff = staffList.find(
                  (staff) => staff.id === parseInt(e.target.value)
                );
                setStaffId(selectedStaff ? selectedStaff.id : ""); // Lưu staffId
                setStaffName(selectedStaff ? selectedStaff.employeeName : ""); // Lưu staffName
              }}
            >
              <option value="">Chọn nhân viên</option>
              {staffList.length > 0 ? (
                staffList.map((staff) => (
                  <option key={staff.id} value={staff.id}>
                    {staff.employeeName}
                  </option>
                ))
              ) : (
                <option value="">Không có nhân viên</option>
              )}
            </Form.Control>
          </Form.Group>
          <Form.Group controlId="formTitle">
            <Form.Label>Tên Ca</Form.Label>
            <Form.Select
              value={title}
              onChange={(e) => setTitle(e.target.value)}
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
