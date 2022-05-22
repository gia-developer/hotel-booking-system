import React, { useState } from "react";
import Title from "./Title";
import Links from "./Link";
import Login from "./login/Login";
import '../styles/Header.css';

function Header() {
    const [isOpen, setIsOpen] = useState(false);
    const toggle = () => setIsOpen(!isOpen);
    {(isOpen ? document.body.style.overflow = 'hidden' : document.body.style.overflow = 'unset' )}

    return (
        <header className={`${isOpen ? 'div__open-menu' : ''}`}>
            <Title />
            <div>
                <a href="#" className="a__button-nav" onClick={toggle}>Abrir/Cerrar</a>
                <div className="div__menu-bar">
                    <p>Menú</p>
                    <nav>
                        <ul className="ul__bar-links">
                            <li><Links href="./login/Login.js" text="Crear cuenta" /></li>
                            <li><Links href="Login.js" text="Iniciar sesión" /></li>
                        </ul>
                        <ul className="ul__social-links">
                            <li><a href="#" className="a__icon-fb">Facebook</a></li>
                            <li><a href="#" className="a__icon-li">LinkedIn</a></li>
                            <li><a href="#" className="a__icon-tw">Twitter</a></li>
                            <li><a href="#" className="a__icon-ig">Instagram</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </header>
    )
}

export default Header;