import React from 'react'
import { BiSearch ,BiNotification} from 'react-icons/bi'
import Button from 'react-bootstrap/Button';
const ContentHeader = () => {
  return (
    <div className='content--header'>
      <h2>DashBoard</h2>
      <div className='header--activity'>
        <div className='search-box'>
            <input type="text" placeholder='Search...' />
            <BiSearch className='icon'/>
            
        </div>
        <div className='notify'>
            <BiNotification className='icon'/>
            
        </div>
      </div>
    </div>
  )
}

export default ContentHeader
