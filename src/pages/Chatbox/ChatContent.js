import { useRef, useCallback, useEffect, useState,useContext } from 'react';
import ChatHistory from './ChatHistory';
import { StoreContext } from "../../context/StoreContext";
import axios from "axios";
import './ChatButton.css';


const ChatContent = (props) => {
    const { stores, setStores } =
    useContext(StoreContext);
    const { setNewMessagesCount, newMessagesCount, setShowChat,product,st,url,unreadUsers,setUnreadUsers } = props;
    const [selectedUser, setSelectedUser] = useState(stores && stores.length > 0 ? stores[0] : '');
    const [searchTerm, setSearchTerm] = useState("");
    const [search, setSearch] = useState(false);
    const [users, setUsers] = useState([]);
    const [loadStores, setLoadStores] = useState(false);
    const [filteredUsers, setFilteredUsers] = useState([]);
    const searchRef = useRef(null);  // Tạo ref cho ô input
    const token = localStorage.getItem("access_token");

     // const fetchAllStoress = async () => {
    //     let res = await GetAllStoresChat();
    //     if (res.EC === 0) {
    //         // Thêm thuộc tính `online` vào từng đối tượng
    //         const updatedStores = res.DT.map(store => ({
    //             ...store,
    //             online: false // Giá trị mặc định cho thuộc tính `online`
    //         }));
    //         dispatch(fetchUpdate({ DT: updatedStores }));
    //     }
    // };

    useEffect(() => {
        console.log("stores thay ddoi: ", stores)
    }, [stores])

    useEffect(()=> {
        console.log("store o conten: ",stores)
    },[])

    useEffect(() => {
        if(st !== null && st !== undefined){
            alert(st)
            setSelectedUser(st);
        }
    },[st])
    // useEffect (() => {
    //     if (stores.length>0){
    //         setSelectedUser(stores[0]);
    //     }
    // },[showChat])

    // useEffect(() => {
    //     console.log("Load lại stores");
    //     fetchAllStores();
    // }, [stores.length]);

    const fetchAllStores = async () => {
        const res = await axios.get(`${url}/api/v1/admin/auth/all`, {
            headers: {
                'Authorization': `Bearer ${token}`  // Thêm token vào header
            }
        });
        if (res.data.message === true) {
            setUsers(res.data.data);
            console.log(res.data.data)
        }
    }

    const handleClickChatContent = () => {
        setShowChat(false);
    };

    const changeUserLocation = (idReceiver, storesRef) => {
        console.log("stores change: ", storesRef.current);
        
        // Tìm kiếm người dùng trong storesRef
        const index = storesRef.current.findIndex(u => u.id === idReceiver);
    
        if (index !== -1) {
            const selectU = storesRef.current[index];
            const newStores = [selectU, ...storesRef.current.slice(0, index), ...storesRef.current.slice(index + 1)];
            
            storesRef.current = newStores;
            setStores([...newStores]); 
        } else {
            loadStoreAgain(storesRef); 
            console.log('Không tìm thấy người dùng');
        }
    };
    

    const updateOnlineStore = (storesRef, isOnlineRef) => {
        const currentStores = storesRef.current;  // Lấy giá trị mới nhất từ storesRef
        const ion = isOnlineRef.current;     // Lấy giá trị mới nhất từ isOnlineRef

        console.log("Danh sách đang online: ", ion);

        // Cập nhật trạng thái `online` của các stores dựa trên danh sách `isOnline`
        const updatedStores = currentStores.map(store => ({
            ...store,
            online: ion.includes(store.id)
        }));

        setStores(updatedStores);
        console.log("Danh sách stores cập nhật: ", updatedStores);
    };
    //
    const handleClickUser = (user) => {
        setSelectedUser(user);
        if(unreadUsers.includes(user.id)){
            setNewMessagesCount(newMessagesCount-1);
            setUnreadUsers((prevUnreadUsers) => {
                return prevUnreadUsers.filter(unreadUser => unreadUser !== user.id);
            });
            updateRead(user.id);
        }

    }

    const updateRead = async(userId)=>{
        try {
            const response = await axios.put(`${url}/api/chats/update/read`, null, {
              params: { userId: userId },
              headers: {
                Authorization: `Bearer ${token}`,  // Thêm token vào header
                'Content-Type': 'application/json' // Chỉ định kiểu nội dung (có thể tùy chỉnh)
              }
            });
            
            if (response.data.EC === 0) {
              console.log('Update successful:', response.data);
            }
          } catch (error) {
            console.error('Error updating read status:', error);
          }
    }

    const handleChangeInput = useCallback((e) => {
        const term = e.target.value;
        setSearchTerm(term);
        if (term === "") {
            // When searchTerm is empty, set filteredUsers to all users
            setFilteredUsers(stores);
        } else {
            // Filter users based on searchTerm
            setFilteredUsers(users.filter(user =>
                user.fullName.toLowerCase().includes(term.toLowerCase())
            ));
        }
    }, [users]);


    const loadStoreAgain = async (storesRef) => {
        try {
            console.log("Loading stores again...");
    
            const previousOnlineUsers = storesRef.current
                .filter(user => user.online === true)
                .map(user => user.id);
    
            const res = await axios.get(`${url}/api/chats/users-chat`, {
                headers: {
                    'Authorization': `Bearer ${token}`  // Add token to the header
                }
            });
    
            if (res.data.EC === 0 && res.data.DT) {
                const updatedStores = res.data.DT.map(store => ({
                    ...store,
                    online: previousOnlineUsers.includes(store.id) // Dựa trên danh sách online trước đó
                }));
    
                storesRef.current = updatedStores;
                setStores([...updatedStores]);  // Spread to ensure state change triggers rerender
            } else {
                console.error("Lỗi khi tải lại stores:", res);
            }
        } catch (error) {
            console.error("Lỗi khi thực hiện loadStoreAgain:", error);
        }
    };

    // xem lại ở đây
    const handleClickNewUser = (user) => {
        setSelectedUser(user);
        const exists = users.some(u => u.id === user.id && u.fullName === user.fullName);
        if (!exists) setLoadStores(true);
        setSearch(false);
        setSearchTerm('');
    }

    const handleClickSearch = async() =>{
        if (searchTerm !== ''){
            console.log("Loading stores again...");
            const res = await axios.get(`${url}/api/chats/search/${searchTerm}`, {
                headers: {
                    'Authorization': `Bearer ${token}`  // Thêm token vào header
                }
            });
            if(res.data.EC === 0){
                console.log("data user: ",res.data.DT)
                setUsers(res.data.DT);
                setFilteredUsers(res.data.DT);
            }
        }
    }
    const handleClickOutside = useCallback((e) => {
        if (searchRef.current && !searchRef.current.contains(e.target)) {
            setSearch(false);  // Đóng danh sách tìm kiếm khi nhấp chuột ra ngoài
        }
    }, []);

    useEffect(() => {
        document.addEventListener('click', handleClickOutside);
        return () => {
            document.removeEventListener('click', handleClickOutside);
        };
    }, [handleClickOutside]);

    return (
        <div className="container-chat">
            <div className="row clearfix">
                <div className="col-lg-12">
                    <div className="card chat-app">
                        <button className="chat-close" onClick={handleClickChatContent}>X</button>
                        <div id="plist" className="people-list">
                            <div className="input-group" ref={searchRef}>
                                <div className="input-group-prepend">
                                    <span className="input-group-text" 
                                    onClick={handleClickSearch}                                     
                                    onKeyDown={(e) => {
                                        if (e.key === 'Enter') {
                                            // e.stopPropagation();
                                            handleClickSearch()
                                        }
                                    }}
                                    tabIndex="0" 
                                    
                                    ><i className="fa fa-search"></i></span>
                                </div>
                                <input
                                    type="text"
                                    className="form-control"
                                    placeholder="Search..."
                                    value={searchTerm}
                                    onChange={(e) => setSearchTerm(e.target.value)}
                                    onClick={() => {
                                        setSearchTerm("")
                                        setSearch(true)
                                    }
                                    }
                                />
                            </div>
                            <ul className="list-unstyled chat-list mt-2 mb-0">
                                {search === false && stores && stores.length > 0 &&
                                    stores.map((item, index) => (
                                        <li key={index} 
                                        className={`clearfix ${selectedUser === item ? 'selected' : ''}  ${unreadUsers.includes(item.id) ? 'unread':''}`}
                                        onClick={() => handleClickUser(item)}>
                                            {
                                                item.avatar ? (
                                                    <img src={`data:image/jpeg;base64,${item.avatar}`} alt="avatar" />
                                                ) :
                                                    <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar" />
                                            }                                            <div className="about">
                                                <div className="name">{item.fullName}</div>
                                                <div className="status"> <i className={`fa fa-circle ${item.online === true ? 'online' : 'offline'}`}></i> {item.online === true ? "online" : "offline"} </div>
                                            </div>
                                        </li>
                                    ))
                                }
                                {search === true && filteredUsers && filteredUsers.length > 0 && filteredUsers.map((item, index) => (
                                    <li key={index} className="clearfix" onClick={(e) => {
                                        e.stopPropagation();
                                        handleClickNewUser(item)
                                    }
                                    }
                                    >
                                        {
                                            item.avatar ? (
                                                <img src={`data:image/jpeg;base64,${item.avatar}`} alt="avatar" />
                                            ) :
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar" />
                                        }
                                        <div className="about">
                                            <div className="name">{item.fullName}</div>
                                            <small><i className={`fa fa-circle ${selectedUser.online === true ? ' online' : ' offline'}`}></i></small>

                                        </div>
                                    </li>
                                ))}
                            </ul>
                        </div>
                        <ChatHistory
                            selectedUser={selectedUser}
                            changeUserLocation={changeUserLocation}
                            setNewMessagesCount={setNewMessagesCount}
                            newMessagesCount={newMessagesCount}
                            updateOnlineStore={updateOnlineStore}
                            product = {product}
                            st = {st}
                            url= {url}
                            unreadUsers= {unreadUsers}
                            setUnreadUsers={setUnreadUsers}
                        />
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ChatContent;
