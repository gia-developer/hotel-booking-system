import {React,useState,useEffect} from 'react';
import { useMediaQuery } from 'react-responsive';
import { Link, useParams } from "react-router-dom";
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

function Product() {
    const mobileTablet = useMediaQuery({ query: '(max-width: 1024px)' });
    const desktop = useMediaQuery({ query: '(min-width: 1025px)' });
    const [product, setProduct] = useState(null);
    const {id} = useParams();

    useEffect(()=>{
        //Cargo datos del producto
        const getProduct = async()=>{
            await fetch("http://localhost:8080/products/findByIdDTO/" + id,{
                method:'GET',
                headers:{
                    'Content-Type':'application/json'
                }
            })
            .then(function(respuesta){
                return respuesta.json();
            })
            .then(function (product) {
                setProduct(product);
            })
        }      
        getProduct();
    },[]);

    return <article className="article__info-product">
        <HeaderProduct name={product?.name} category={product?.category.title} />
        <InfoProduct address={product?.adress} punctuation={product?.punctuation} stars={product?.stars} score={product?.score}/>
        <div className="div__img-actions">
            <div className="div__buttons-bar">
                <Link to="#" className="a__share-icon">Compartir</Link>
                <Link to="#" className="a__like-icon">Me gusta</Link>
            </div>
            {mobileTablet && <GalleryMobile srcImg={product?.images} altImg={product?.category.title} />}
            {desktop && <GalleryDesktop srcImg={product?.images} altImg={product?.category.title} />}
        </div>
        <DescriptionHotel title={product?.descTitle} text={product?.desc} />
        <LocationServices services={product?.characteristic} />
        <HotelDate />
        <MapLocation city={product?
            product.city?.cityName + ", " + product.city?.country
            :""} />
        <Politis info={product?.policy} />
    </article>
}

export default Product;