import { useEffect, useState,useContext } from 'react';
import './ChatButton.css';
import ChatContent from './ChatContent';
import axios from "axios";
import { StoreContext } from "../../context/StoreContext";
import '@fortawesome/fontawesome-free/css/all.min.css';

const ChatButton = (props) => {
    const {showChat,setShowChat,product ,url} = props;
    const [newMessagesCount, setNewMessagesCount] = useState(1);
    const token = localStorage.getItem("access_token");
    const { stores, setStores } =
    useContext(StoreContext);
    const [unreadUsers,setUnreadUsers] = useState([]);

    useEffect(() => {
        fetchAllStores();
        GetAllUnRead();
    }, []);
    useEffect(()=>{
        console.log("change new message count: ",newMessagesCount)
    },[])
    useEffect(()=>{
        console.log("change new message count: ",newMessagesCount)
    },[newMessagesCount])
    // useEffect(() => {
    //     GetAllUnRead();
    // }, []); 
    // Chạy lại khi stores thay đổi

    const GetAllUnRead = async () => {
        try {
            const res = await axios.get(`${url}/api/chats/users/unread`, {
                headers: {
                    'Authorization': `Bearer ${token}`  // Thêm token vào header
                }
            });
            if (res.data.EC === 0) {
                console.log("Lấy tin nhắn chưa đọc thành công");
                console.log("data unread: ", res);
                // Lấy danh sách người dùng có is_online là false
                const usersWithUnread = res.data.DT;
                const unreadUserIds = usersWithUnread.map(user => user.id);
                setTimeout(() => {
                    setNewMessagesCount(usersWithUnread.length);
                    setUnreadUsers(unreadUserIds);
                  }, 2000);
                  console.log("new unread chatbutoon: ",unreadUsers);
            } else {
                console.error("Lỗi khi lấy tin nhắn chưa đọc:", res);
            }
        } catch (error) {
            console.error("Lỗi khi thực hiện GetAllUnRead:", error);
        }
    }

    const fetchAllStores = async () => {
        try {
            console.log("fetchData được gọi"); 
            const res = await axios.get(`${url}/api/chats/users-chat`, {
                headers: {
                    'Authorization': `Bearer ${token}`  // Thêm token vào header
                }
            });
            console.log("dl trả về", res.data.DT);
            if (res.data.EC === 0) {
                const updatedStores = res.data.DT.map(store => ({
                    ...store,
                    online: false, // Giá trị mặc định cho thuộc tính `online`
                    is_online:true
                }));
                console.log("Đang cập nhật stores...");
                console.log("update store but: ", stores)
                setStores(updatedStores);
            }
        } catch (error) {
            console.error("Lỗi khi lấy dữ liệu cửa hàng:", error);
        }
    };

    return (
        <div>
            {/* Nút chat */}
            <div className={`chat-button ${showChat ? 'hidden' : 'visible'}`} onClick={() => setShowChat(!showChat)}>
                <button>Chat
                    {newMessagesCount > 0 && (
                        <span className="notification-badge">{newMessagesCount}</span>
                    )}
                </button>
            </div>

            {/* ChatContent luôn tồn tại trong DOM nhưng được ẩn */}
            <div className={`chat-content ${showChat ? 'visible' : 'hidden'}`}>
                <ChatContent
                    showChat={showChat}
                    setShowChat={setShowChat}
                    setNewMessagesCount={setNewMessagesCount}
                    newMessagesCount ={newMessagesCount}
                    product = {product}
                    url={url}
                    unreadUsers = {unreadUsers}
                    setUnreadUsers={setUnreadUsers}
                />
            </div>
        </div>
    )
};

export default ChatButton;