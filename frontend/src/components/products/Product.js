import React, {Fragment} from 'react';
import { Link } from "react-router-dom";
import HeaderProduct from './HeaderProduct';
import InfoProduct from './InfoProduct';

function Product({src, alt, title, text}) {
    return (
        <Fragment>
            <HeaderProduct />
            <InfoProduct />
            <div className="div__img-actions">
                <div className="div__buttons-bar">
                    <Link to="#" class="a__share-icon">Compartir</Link>
                    <Link to="#" class="a__like-icon">Me gusta</Link>
                </div>
                <ul className='ul__gallery-img'>
                    <li><img src={`${src}`} alt={`${alt}`} /></li>
                    <li><img src={`${src}`} alt={`${alt}`} /></li>
                    <li><img src={`${src}`} alt={`${alt}`} /></li>
                    <li><img src={`${src}`} alt={`${alt}`} /></li>
                    <li><img src={`${src}`} alt={`${alt}`} /></li>
                </ul>
            </div>
            <h2>Alójate en el corazón de Buenos Aires</h2>
            <p>Está situado a solo unas calles de la avenida Alvear, de la avenida Quintana, del parque San Martín y del distrito de Recoleta. En las inmediaciones también hay varios lugares de interés, como la calle Florida, el centro comercial Galerías Pacífico, la zona de Puerto Madero, la plaza de Mayo y el palacio Municipal.<br />
            Nuestros clientes dicen que esta parte de Buenos Aires es su favorita, según los comentarios independientes.<br />
            El Hotel es un hotel sofisticado de 4 estrellas que goza de una ubicación tranquila, a poca distancia de prestigiosas galerías de arte, teatros, museos y zonas comerciales. Además, hay WiFi gratuita.<br />
            El establecimiento sirve un desayuno variado de 07:00 a 10:30.</p>
            {/*<h2>${title}</h2>
            <p>${text}</p>*/}
        </Fragment>
    )
}

export default Product;