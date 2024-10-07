import React from 'react';
// import Users from '../components/ManageUsers/Users';
// import PrivateRoutes from './PrivateRoutes';
// import Role from '../components/Role/Role';
// import GroupRole from '../components/GroupRole/GroupRole';
// import Home from '../components/Home_About/Home';

import { Route, Routes } from "react-router-dom";
import Home from '../pages/Home/Home';
import Introduce from '../pages/Introduce/Introduce';
import Category from '../pages/Category/Category';
import Promotion from '../pages/Promotion/Promotion';
import Store from '../pages/store/store';
import Cart from '../pages/Cart/Cart';
import PlaceOrder from '../pages/PlaceOrder/PlaceOrder';
import Contact from '../pages/Contact/Contact';
import Account from '../pages/Account/Account';

const Projects = () => { // component
    return (
        <span>Projects</span>
    )
}

const AppRoutes = (props) => {
    return (
        <>
            <Routes>
                {/* <PrivateRoutes path='/users' element={Users} />
                <PrivateRoutes path='/roles' element={Role} />
                <PrivateRoutes path='/group-role' element={GroupRole} /> */}
                <Route path="/" element={<Home />} />
                <Route path="/introduce" element={<Introduce />} />
                <Route path="/category" element={<Category />} />
                <Route path="/promotion" element={<Promotion />} />
                <Route path="/store" element={<Store />} />
                <Route path="/cart" element={<Cart />} />
                <Route path="/order" element={<PlaceOrder />} />
                <Route path="/contact" element={<Contact />} />
                <Route path="/account/*" element={<Account />} />
                <Route path="*" element={<div>404 Not Found!!!</div>} />

            </Routes>
            {/* <Switch>
                <PrivateRoutes path='/users' component={Users} />
                <PrivateRoutes path='/roles' component={Role} />
                <PrivateRoutes path='/group-role' component={GroupRole} />
                
                <Route path="/" exact>
                    <Home/>
                </Route>
                <Route path="/login">
                    <Login />
                </Route>
                <Route path="/register">
                    <Register />
                </Route>
                <Route path="/about">
                    <About/>
                </Route>
                <Route path="/projects">
                    <Projects/>
                </Route>
                <Route path="*">
                    404 Not Found!!!
                </Route>
            </Switch> */}

        </>
    );
}

export default AppRoutes;