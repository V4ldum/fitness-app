use crate::drivers::security::{get_access_token, get_refresh_token, decode_token};
use std::path::Path;
use rocket::http::Status;
use rocket::response::{status, NamedFile};
use rocket_contrib::json::Json;
use super::entities::User;
use serde_json::Value;


#[get("/login/auth?<username>&<password>")]
pub fn authenticate_with_credentials(username: String, password: String) -> status::Custom<Json<Value>> {
    let user = User::get_user_by_username_password(username, password);

    if user.is_none() {
        //Incorrect username or password
        status::Custom(Status::Unauthorized, Json(json!({
            "status": 401,
            "result": "Nom d'utilisateur ou mot de passe incorrect.",
        })))
    } else {
        //Correct username and password
        let user = user.unwrap();

        status::Custom(Status::Ok, Json(json!({
            "status": 200,
            "result": &user,
            "access_token": get_access_token(&user),
            "refresh_token": get_refresh_token(&user),
        })))
    }
}

#[get("/login/access?<token>")]
pub fn authenticate_with_token(token: String) -> status::Custom<Json<Value>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        //Valid Token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Access" {
            //Access token is used
            let username = claims.username;
            let user = User::get_user_by_username(username);
    
            status::Custom(Status::Ok, Json(json!({
                "status": 200,
                "result": user,
            })))
        } else { 
            //Not an access token
            status::Custom(Status::Unauthorized, Json(json!({
                "status": 401,
                "result": "Token d'accès non valide.",
            })))
        }
    } else {
        //Invalid token
        status::Custom(Status::Unauthorized, Json(json!({
            "status": 401,
            "result": "Token d'accès non valide.",
        })))
    }
}

#[get("/login/refresh?<token>")]
pub fn refresh_token(token: String) -> status::Custom<Json<Value>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        //Valid token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Refresh" {
            //Refresh token is used
            let username = claims.username;
            let user = User::get_user_by_username(username).unwrap();
            
            status::Custom(Status::Ok, Json(json!({
                "status": 200,
                "access_token": get_access_token(&user),
                "refresh_token": get_refresh_token(&user),
            })))
        } else { 
            //Not a refresh token
            status::Custom(Status::Unauthorized, Json(json!({
                "status": 401,
                "result": "Token non valide.",
            })))
        }
    } else {
        //Invalid token
        status::Custom(Status::Unauthorized, Json(json!({
            "status": 401,
            "result": "Token non valide.",
        })))
    }
}

#[get("/user/picture?<token>")]
pub fn get_user_picture(token: String) -> status::Custom<Option<NamedFile>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        // Valid token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Access" {
            //Access token is used
            let asset = User::get_user_picture(claims.username);

            if !asset.is_none() {
                status::Custom(Status::Ok, NamedFile::open(Path::new("assets/").join(asset.unwrap())).ok())
            } else {
                //Picture Not Found
                status::Custom(Status::NotFound, None)
            }
        } else { 
            //Not an access token
        status::Custom(Status::Unauthorized, None)
        }
    } else {
        //Invalid token
        status::Custom(Status::Unauthorized, None)
    }
}

#[get("/user/<username>/picture?<token>")]
pub fn get_picture_from_username(username: String, token: String) -> status::Custom<Option<NamedFile>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        // Valid token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Access" {
            //Access token is used
            let asset = User::get_user_picture(username);

            if !asset.is_none() {
                status::Custom(Status::Ok, NamedFile::open(Path::new("assets/").join(asset.unwrap())).ok())
            } else {
                //Picture Not Found
                status::Custom(Status::NotFound, None)
            }
        } else { 
            //Not an access token
        status::Custom(Status::Unauthorized, None)
        }
    } else {
        //Invalid token
        status::Custom(Status::Unauthorized, None)
    }
}