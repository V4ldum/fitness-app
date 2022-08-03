use crate::drivers::security::decode_token;

use rocket_contrib::json::Json;
use rocket::http::Status;
use rocket::response::status;
use super::entities::{Comment, Reply};
use serde_json::Value;

#[get("/comments?<week>&<day>&<token>")]
pub fn get_comment_from_week_and_day(week: i32, day: i32, token: String) -> status::Custom<Json<Value>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        // Valid token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Access" {
            // Access token is used
            let comments = Comment::get_comments_by_week_and_day(week, day);

            status::Custom(Status::Ok, Json(json!({
                "status": 200,
                "comments": comments,
            })))
        } else {
            // Not an access token
            status::Custom(Status::Unauthorized, Json(json!({
                "status": 401,
                "result": "Token d'accès non valide.",
            })))
        }
    } else {
        // Invalid token
        status::Custom(Status::Unauthorized, Json(json!({
            "status": 401,
            "result": "Token d'accès non valide.",
        })))
    }
}

#[get("/comments/<comment_id>?<token>")]
pub fn get_comment_from_id(comment_id: i32, token: String) -> status::Custom<Json<Value>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        // Valid token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Access" {
            // Access token is used
            let comment = Comment::get_comment_by_id(comment_id);

            status::Custom(Status::Ok, Json(json!({
                "status": 200,
                "comment": comment,
            })))
        } else {
            // Not an access token
            status::Custom(Status::Unauthorized, Json(json!({
                "status": 401,
                "result": "Token d'accès non valide.",
            })))
        }
    } else {
        // Invalid token
        status::Custom(Status::Unauthorized, Json(json!({
            "status": 401,
            "result": "Token d'accès non valide.",
        })))
    }
}

#[get("/replies?<comment_id>&<token>")]
pub fn get_replies_from_id(comment_id: i32, token: String) -> status::Custom<Json<Value>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        // Valid token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Access" {
            // Access token is used
            let comment = Comment::get_comment_by_id(comment_id);
            let replies = Reply::get_reply_from_comment_id(comment_id);

            status::Custom(Status::Ok, Json(json!({
                "status": 200,
                "comment": comment,
                "replies": replies,
            })))
        } else {
            // Not an access token
            status::Custom(Status::Unauthorized, Json(json!({
                "status": 401,
                "result": "Token d'accès non valide.",
            })))
        }
    } else {
        // Invalid token
        status::Custom(Status::Unauthorized, Json(json!({
            "status": 401,
            "result": "Token d'accès non valide.",
        })))
    }
}