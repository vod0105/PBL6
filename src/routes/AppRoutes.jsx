import React from 'react';
import { Route, Routes } from "react-router-dom";
import PrivateRoutes from './PrivateRoutes';
import Home from '../pages/Home/Home';
import Introduce from '../pages/Introduce/Introduce';
import Category from '../pages/Category/Category';
import Promotion from '../pages/Promotion/Promotion';
import Cart from '../pages/Cart/Cart';
import Contact from '../pages/Contact/Contact';
import Account from '../pages/Account/Account';
import ProductItemDetail from '../components/ProductItemDetail/ProductItemDetail';
// import Store_Old from '../pages/Store_Old/Store_Old';
import Store from '../pages/Store/Store';
import StoreDetail from '../pages/StoreDetail/StoreDetail';
import PlaceOrder from '../pages/PlaceOrder/PlaceOrder';
import Checkout from '../pages/Checkout/Checkout';
import OrderComplete from '../pages/OrderComplete/OrderComplete';
import PromotionDetail from '../pages/PromotionDetail/PromotionDetail';
import OAuth2RedirectHandler from '../components/OAuth2RedirectHandler/OAuth2RedirectHandler';
import RouteMap from '../components/RouteMap/RouteMap';
import DeliveryMap from '../components/DeliveryMap/DeliveryMap';
import Combo from '../pages/Combo/Combo';
import ComboItemDetail from '../components/ComboItemDetail/ComboItemDetail';
import Download from '../pages/Download/Download';
import AllProducts from '../pages/AllProducts/AllProducts';
import Loading from '../pages/Loading/Loading';

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
                <Route path="/category/:id" element={<Category />} />
                <Route path="/combo" element={<Combo />} />
                <Route path="/all-products" element={<AllProducts />} />

                <Route path="/promotion" element={<Promotion />} />
                {/* <Route path="/store" element={<Store_Old />} /> */}
                <Route path="/cart" element={<Cart />} />
                <Route path="/order" element={<PlaceOrder />} />
                <Route path="/contact" element={<Contact />} />
                <Route path="/account/*" element={<Account />} />

                <Route path="/product-detail/:id" element={<ProductItemDetail />} />
                <Route path="/combo-detail/:id" element={<ComboItemDetail />} />

                <Route path="/store" element={<Store />} />
                <Route path="/store-detail/:id" element={<StoreDetail />} />

                <Route path="/checkout" element={<Checkout />} />
                <Route path="/promotion-detail/:id" element={<PromotionDetail />} />
                <Route path="/order-complete" element={<OrderComplete />} />

                <Route path="/oauth2/redirect" element={<OAuth2RedirectHandler />} />
                <Route path="/test-loading" element={<Loading />} />
                <Route path="/order-in-transit/:orderCode" element={<DeliveryMap />} />

                <Route path="/download" element={<Download />} />

                <Route path="*" element={<div>404 Not Found!!!</div>} />

            </Routes>
        </>
    );
}

export default AppRoutes;