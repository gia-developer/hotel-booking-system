import { React, useState, useEffect, useContext } from 'react';
import { useParams , useNavigate } from "react-router-dom";
import HeaderProduct from "../Products/HeaderProduct";
import Form from "./Form";
import Calendar from "../Products/Calendar";
import Hour from "./Hour";
import Details from "./Details";
import Politics from "../Products/Politics";
import { UserContext } from "../Context/UserContext";
import { SearchContext } from '../Context/SearchContext';
import "../../styles/Booking/Booking.css";
import "../../styles/Booking/Date.css";

function Booking() {
    const [product, setProduct] = useState(null);
    const {id} = useParams();
    const navigate = useNavigate();
    localStorage.removeItem("url");
    const {user} = useContext(UserContext);
    const token = localStorage.getItem("token");
    let error;

    const city = document.querySelector("#input__city-booking");
    const description = document.querySelector("#textarea__description-booking");
    const checkCovid = document.querySelector("#label__covid");
    const hour = document.querySelector("#select__option-hour");

    const startDayGet = useContext(SearchContext).startDateCache.getDate().toString();
    const startDay = startDayGet.length === 1 ? "0" + startDayGet : startDayGet;
    const startMonthGet = useContext(SearchContext).startDateCache.getMonth().toString();
    const startMonth = startMonthGet.length === 1 ? "0" + startMonthGet : startMonthGet;
    const startYear = useContext(SearchContext).startDateCache.getFullYear();

    const endDayGet = useContext(SearchContext).endDateCache.getDate().toString();
    const endDay = endDayGet.length === 1 ? "0" + endDayGet : endDayGet;
    const endMonthGet = useContext(SearchContext).endDateCache.getMonth().toString();
    const endMonth = endMonthGet.length === 1 ? "0" + endMonthGet : endMonthGet;
    const endYear = useContext(SearchContext).endDateCache.getFullYear();

    useEffect(()=>{
        //Cargo datos del producto
        const getProduct = async()=>{
            await fetch("http://localhost:8080/products/findById/" + id,{
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
    }, [id]);

    const handlerSubmit = (e) => {
        e.preventDefault();
        
        console.log(city.value.trim());
        if(city.value.trim() === ""){
            city.focus();
            city.className = "error";
            return
        }

        if(hour.value === ""){
            hour.focus();
            hour.className = "error";
            return
        }

        //Insert con datos de la reserva
        const insertBooking = async()=>{
            await fetch("http://localhost:8080/bookings/insert", {
                method:'POST',
                headers: {
                    "Access-Control-Allow-Headers" : "Content-Type",
                    'Access-Control-Allow-Origin': "*",
                    'Content-Type': 'application/json',
                    "Authorization": `Bearer ${token}`
                }, body: JSON.stringify({
                    bookingStarTime: hour.value,
                    bookingStartDate: `${startYear}-${startMonth}-${startDay}`,
                    bookingFinishDate: `${endYear}-${endMonth}-${endDay}`,
                    bookingCity: city.value,
                    bookingVaccineCovid: checkCovid.checked,
                    bookingUserInfoCovid: description.value,
                    prodId:{
                        id: parseInt(id)
                    },
                    userId:{
                        id: user.id
                    }
                })
            })
            .then((response) => {
                if(response.status === 200) navigate("/ok");
                return response.json();
            })
        }
        insertBooking();
    }

    return (
        <section className='section__booking-hotel'>
            <HeaderProduct name={product?.name} category={product?.category.title} />
            <form method="POST" className='div__booking-hotel' onSubmit={handlerSubmit}>
                <div>
                    <Form />
                    <section className='section__booking-date'>
                        <h2>Seleccioná tu fecha de reserva</h2>
                        <Calendar bookings={product?.bookings}/>
                    </section>
                    <Hour />
                </div>
                <Details src={product?.images[0]?.nombre_url} name={product?.name} category={product?.category.title} address={product?.address} city={product? product.city?.cityName + ", " + product.city?.country : ""} stars={product?.stars} />
            </form>
            <Politics policy={product?.policy} />
        </section>
    )
}

export default Booking;