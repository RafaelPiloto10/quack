from pydantic import BaseModel
from fastapi import APIRouter, status, Response
import re
from database import db

router = APIRouter(prefix="/user")


"""
    UserLogin model keeps track of the user login information
    username: str
        The username of the user
    email: str
        The email of the user
    password: str
        The password of the user
"""
class User(BaseModel):
    name: str
    email: str
    password: str


"""
    getuser implements the route /login/
    returns message
"""
# TODO: Once attached to database will be able to retreive
# specific user information and to log them in
@router.get("/login/")
async def login():
    return {"msg": "This is the login page!"}


"""
    registeruser implements the /register/ route
    login: User
        The UserLogin model that includes the username, email, and password
    resp: Response
        The response to send back to the user which contains the status code and body
    returns Response
        Response.body: dict
            Provides any msgs/errs for the request
        Response.status: int
            The status code for the request
"""
@router.post("/register", status_code=status.HTTP_201_CREATED)
async def register(login: User, resp: Response):

    name = login.name
    email = login.email
    password = login.password

    # params are it must end with @emory.edu
    validEmail = r'\b[A-Za-z0-9._%+-]+@emory.edu\b'
    # valid password is the regular expression of the valid format the password should be
    # params are 8 to 20 character length, contain one upper case, one lower case, and one digit
    validPassword = r'^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])[\w\d@#$]{8,20}'

    if name.strip() == "":
        resp.status_code = status.HTTP_400_BAD_REQUEST
        return {"err" : "Invalid name. Cannot be empty."}

    # check if email is a valid emory email
    if not (re.search(validEmail, email)):
        resp.status_code = status.HTTP_400_BAD_REQUEST
        return {"err" : "Invalid email address. It must be an emory.edu email."}

    # check if password is a valid password
    if not (re.search(validPassword, password)):
        resp.status_code = status.HTTP_400_BAD_REQUEST
        return {"err" : "Invalid password. It must be 8 to 20 characters and have at least one upper case letter, one lower case letter, and one digit."}

    # adds user to the database
    new_user = {
        "name": name,
        "email": email,
        "password": password
    }

    msg = db.save_user_in_db(new_user)
    if "err" in msg:
        resp.status_code = status.HTTP_400_BAD_REQUEST

    return msg
