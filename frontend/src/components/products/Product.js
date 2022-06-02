import React from 'react';
import { useMediaQuery } from 'react-responsive';
import { Link } from "react-router-dom";
import HeaderProduct from './HeaderProduct';
import InfoProduct from './InfoProduct';
import GalleryMobile from "./GalleryMobile";
import GalleryDesktop from "./GalleryDesktop";
import DescriptionHotel from "./DescriptionHotel";
import LocationServices from "./LocationServices";
import MapLocation from "./MapLocation";
import Politis from './Politics';
import HotelDate from "./HotelDate";
import "../../styles/products/Product.css";

function Product({src, alt}) {
    const mobileTablet = useMediaQuery({ query: '(max-width: 1024px)' });
    const desktop = useMediaQuery({ query: '(min-width: 1025px)' });

    return <article className="article__info-product">
        <HeaderProduct />
        <InfoProduct />
        <div className="div__img-actions">
            <div className="div__buttons-bar">
                <Link to="#" className="a__share-icon">Compartir</Link>
                <Link to="#" className="a__like-icon">Me gusta</Link>
            </div>
            {mobileTablet && <GalleryMobile />}
            {desktop && <GalleryDesktop />}
        </div>
        <DescriptionHotel />
        <LocationServices />
        <HotelDate />
        <MapLocation />
        <Politis />
    </article>
}

export default Product;