import axios from "../setup/axios"; // an instance of axios

const GetAllStores = () => {
    return axios.get("/api/v1/admin/auth/all");
}

const GetAllStoresChat = () => {
    return axios.get("api/chats/users-chat");
}

const GetChatHistory = (idReceiver) => {
    return axios.get(`api/chats/receiver/${idReceiver}`);
}

const GetUnRead = () => {
    return axios.get(`api/chats/users/unread`);
}

const PutUpdateRead = (userId) => {
    return axios.put(`api/chats/update/read`, null, {
        params: { userId: userId }
    });
}

const searchUsers = (searchTerm) => {
    return axios.get(`api/chats/search/${searchTerm}`);
}

const GetMarkMessagesAsRead = (idSender) => {
    return axios.get(`api/chats/mark-messages-as-read/${idSender}`)
}

const PostImageChat = (sender, receiver, isRead, image) => {
    const data = new FormData();
    data.append('sender', sender);
    data.append('receiver', receiver);
    data.append('isRead', isRead);
    data.append('image', image);
    // console.log("image api: ", image)
    return axios.post('api/chats/saveImage', data);
}

const searchOwnerForStore = (idStore) => {
    return axios.get(`api/chats/searchOwner/${idStore}`);
}

const PostSaveMess = (sender, receiver, isRead, mess) => {
    const data = new FormData();
    data.append('sender', sender);
    data.append('receiver', receiver);
    data.append('isRead', isRead);
    data.append('mess', mess);
    return axios.post('api/chats/saveMessage', data);
}

const GetAllOwner = () => {
    return axios.get(`api/chats/all/owner/store`);
}
const findStoreByOwner = (id) => {
    return axios.get(`api/chats/findStore/${id}`);
}
export {findStoreByOwner,GetAllOwner,PostSaveMess,searchOwnerForStore,searchUsers,PutUpdateRead,PostImageChat,GetUnRead,GetMarkMessagesAsRead, GetAllStoresChat,GetChatHistory,GetAllStores}