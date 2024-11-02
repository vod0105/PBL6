import React, { createContext, useState } from 'react';

const ChatContext = createContext();

export const ChatProvider = ({ children }) => {

    const [showChat, setShowChat] = useState(false);
    const [selectedUser, setSelectedUser] = useState('');


  return (
    <ChatContext.Provider value={{ showChat, setShowChat, selectedUser, setSelectedUser  }}>
      {children}
    </ChatContext.Provider>
  );
};

export default ChatContext;
