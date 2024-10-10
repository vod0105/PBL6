import React from 'react';
// import Users from '../components/ManageUsers/Users';
// import PrivateRoutes from './PrivateRoutes';
// import Role from '../components/Role/Role';
// import GroupRole from '../components/GroupRole/GroupRole';
// import Home from '../components/Home_About/Home';

import { Route, Routes } from "react-router-dom";
import PrivateRoutes from './PrivateRoutes';
import Home from '../pages/Home/Home';
import Introduce from '../pages/Introduce/Introduce';
import Category from '../pages/Category/Category';
import Promotion from '../pages/Promotion/Promotion';
import Cart from '../pages/Cart/Cart';
import PlaceOrder from '../pages/PlaceOrder/PlaceOrder';
import Contact from '../pages/Contact/Contact';
import Account from '../pages/Account/Account';
import ProductItemDetail from '../components/ProductItemDetail/ProductItemDetail';
import Store_Old from '../pages/Store_Old/Store_Old';
import Store from '../pages/Store/Store';

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

                {/* PrivateRoutes */}
                {/* <Route path='/introduce' element={<PrivateRoutes element={<Introduce />} />} /> */}

                <Route path="/" element={<Home />} />
                <Route path="/introduce" element={<Introduce />} />
                <Route path="/category" element={<Category />} />
                <Route path="/promotion" element={<Promotion />} />
                <Route path="/store" element={<Store_Old />} />
                <Route path="/cart" element={<Cart />} />
                <Route path="/order" element={<PlaceOrder />} />
                <Route path="/contact" element={<Contact />} />
                <Route path="/account/*" element={<Account />} />

                <Route path="/test-product-detail" element={<ProductItemDetail />} />
                <Route path="/test-store" element={<Store />} />

                <Route path="*" element={<div>404 Not Found!!!</div>} />

            </Routes>
        </>
    );
}

export default AppRoutes;