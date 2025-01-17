import { Link , useNavigate ,useLocation } from "react-router-dom";
import { useState, useEffect } from 'react';
import emailjs from 'emailjs-com';
import Button from "../Button";
import '../../styles/Login.css';
import EmailKey from "../SendEmail/EmailKey";
import Api from "../Helpers/Api";

function Register({type}) {
    const [errors,setError]=useState({})
    const navigate = useNavigate();
    const [name, setName] = useState("");
    const [lastname, setLastname] = useState("");
    const [email, setEmail] = useState("");
    const location = useLocation()

    const handlerSubmit = (e)=>{
        e.preventDefault()

        const nombreValue = document.querySelector("#input__name")
        const apellidoValue = document.querySelector("#input__lastname");
        const emailValue =  document.querySelector("#email_login");
        const passwordValue = document.querySelector("#password_login");
        const passwordRepeat = document.querySelector("#repeat_login");
        let ret;

        //LIMPIO ERRORES 
        setError({})

        //VALIDO NOMBRE
        ret = validateInput("GENERAL",nombreValue.value)
        if(ret !== ''){   
            setError({name:[ret]})
            return
        }

        //VALIDO APELLIDO
        ret = validateInput("GENERAL",apellidoValue.value)
        if(ret !== ''){   
            setError({lastname:[ret]})
            return
        }

        //VALIDO EMAIL
        ret = validateInput("EMAIL",emailValue.value)
        if(ret !== ''){   
            setError({email:[ret]})
            return
        }

        //VALIDO PASSWORD
        ret =validateInput("PASSWORD",passwordValue.value)
        if(ret !== ''){       
            setError({password:[ret]})
            return
        }

        //VALIDO PASSWORD REPEAT
        ret =validateInput("PASSWORD",passwordRepeat.value)
        if(ret !== ''){       
            setError({passwordRepeat:[ret]})
            return
        }

        //VALIDO QUE SEAN IGUALES
        if(passwordValue.value.trim()!==passwordRepeat.value.trim()){
            setError({passwordRepeat:["No coinciden las contraseñas"]})
            return
        }

        const register = async() => {
            await fetch(Api + "users/register", {
                method:'POST',
                headers:{
                    "Access-Control-Allow-Headers" : "Content-Type",
                    'Access-Control-Allow-Origin':"*",
                    'Content-Type':'application/json'
                }, body:JSON.stringify ({
                    userName:nombreValue.value.trim(),
                    userSurname:apellidoValue.value.trim(),
                    userEmail:emailValue.value.trim(),
                    userPassword:passwordValue.value.trim(),
                    userCity:"",
                    role: {id: location.pathname.includes("admin")?1:2}
                })
            })
            .then((response) => {
                console.log(response);
                if(response.status === 201) {               
                        return response.json()         
                } else if(response.status === 406) {
                   setError({email:["Ya existe un usuario con el email ingresado"]})
                   return
                } else {
                    setError({password:["Lamentablemente no ha podido registrarse. Por favor intente más tarde"]})
                    return
                }
              })
              .then(user=>{
                //valido que devolvio el usuario
                if(!user){
                    return
                }
                
                    let emailBody = `Realiza la confirmacion de tu cuenta ingresando en: http://ec2-54-175-55-158.compute-1.amazonaws.com/accountconfirmation/${user.id}`;
                     emailjs.send(`service_lmsq0hp`, EmailKey.TEMPLATE_ID, {email:user.userEmail, name:user.userName, lastname:user.userSurname,message:emailBody}, EmailKey.USER_ID)
                    .then((result) => {
                  
                    },
                    (error) => {
                    
                    });

                navigate("/login"); // logueo para obtener token
              })
              .catch((error) => {
                setError({password:["Error, intente de nuevo mas tarde"]})
                return
              });
        }
        register();
    }

    //VALIDO CAMPO EMAIL
    const validateInput = (type,value) => { 
        value = value.trim() //hago un trim para sacar los espacios

        switch (type) {
            case 'GENERAL':
                    if (value.length === 0 ){
                        return "El campo es obligatorio"; 
                    }
                    break;
            case 'EMAIL':
                    if (value.length === 0 ){
                        return "El campo es obligatorio"; 
                    }

                    if (!value.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/ )) {
                        return "El campo email no cumple con el formato";
                   }
                break;
            case 'PASSWORD':
                    if (value.length === 0 ){
                      return "El campo es obligatorio"; 
                    }  

                    if (value.length < 6) {
                         return "La contraseña debe contener más de 6 caracteres"
                    }

                    if (!value.match(/[A-Z]/)) {
                        return "El campo debe contener al menos una letra mayúscula"
                    }

                    if (!value.match(/[a-z]/)) {
                        return "El campo debe contener al menos una letra minúscula"
                    }

                    if (!value.match(/[0-9]/)) {
                        return "El campo debe contener al menos un número"
                    }
                    break;
            default:
                return "Caso no contemplado!";
        }
          
        //RETORNO VACIO NO HUBO ERRORES
        return "";
    }

    //Mostrar u ocultar contraseña
    function show(e) {
        e.preventDefault();
        const input = e.target.previousElementSibling;
        e.target.classList.toggle("show");
        input.type === "password" ? input.type = "text" : input.type = "password";
    }
    
    if(type) document.body.className = `${type}`;

    useEffect(() => {
        localStorage.setItem("name", JSON.stringify(name));
        localStorage.setItem("lastname", JSON.stringify(lastname));
        localStorage.setItem("email", JSON.stringify(email));
    }, [name, lastname, email]);

    return (
        <section className="section__form-data">
            <h2>Crear cuenta</h2>
            <form action="POST" onSubmit={handlerSubmit}>
                <label htmlFor="input__name" className="label__input-name">
                    <span>Nombre</span>
                    <input type="text" name="name" id="input__name" required autoComplete="off" value={name} onChange={(e) => setName(e.target.value)} />
                    {errors.name?
                    <small className="small__error" id="error_nombre">{errors.name}</small>:
                    <small className="small__error"></small>
                    }
                </label>
                <label htmlFor="input__lastname" className="label__input-name">
                    <span>Apellido</span>
                    <input type="text" name="lastname" id="input__lastname" required autoComplete="off" value={lastname} onChange={(e) => setLastname(e.target.value)} />
                    {errors.lastname?
                    <small className="small__error" id="error_email">{errors.lastname}</small>:
                    <small className="small__error"></small>
                    }
                </label>
                <label htmlFor="email_login">
                    <span>Correo electrónico</span>
                    <input type="email" name="email" id="email_login" required autoComplete="off" className={`${errors.email ? "error" : ""}`} value={email} onChange={(e) => setEmail(e.target.value)} />

                    {errors.email?
                    <small className="small__error" id="error_email">{errors.email[0]}</small>:
                    <small className="small__error"></small>
                    }
                </label>
                <label htmlFor="password_login" className='label__password-input'>
                    <span>Contraseña</span>
                    <input type="password" name="password" id="password_login" required autoComplete="off" className={`${errors.password ? "error" : ""}`} />
                    <Link to="#" className="a__show-hide" onClick={show}>Show/Hide</Link>

                    {errors.password?
                    <small className="small__error" id="error_password">{errors.password[0]}</small>:
                    <small className="small__error"></small>
                    }
                </label>
                <label htmlFor="repeat_login" className='label__password-input'>
                    <span>Confirmar contraseña</span>
                    <input type="password" name="password-confirm" id="repeat_login" required className={`${errors.passwordRepeat ? "error" : ""}`} />
                    <Link to="#" className="a__show-hide" onClick={show}>Show/Hide</Link>

                    {errors.passwordRepeat?
                    <small className="small__error" id="error_password">{errors.passwordRepeat[0]}</small>:
                    <small className="small__error"></small>
                    }
                </label>
                <Button text="Crear cuenta" type="submit" className="btn button__solid-type" />
            </form>
            <p>¿Ya tienes una cuenta? <Link to="/login">Iniciar sesión</Link></p>
        </section>
    )
  }
  
export default Register;