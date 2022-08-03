use crate::drivers::security::decode_token;

use rocket_contrib::json::Json;
use rocket::http::Status;
use rocket::response::status;
use super::entities::DailyProgram;
use serde_json::Value;

#[get("/daily?<week>&<token>")]
pub fn get_daily_program_from_week(week: i32, token: String) -> status::Custom<Json<Value>> {
    let decoded = decode_token(token);

    if decoded.is_ok() {
        // Valid token
        let claims = decoded.unwrap().claims;
        if claims.kind == "Access" {
            //Access token is used
            let program = DailyProgram::get_program_by_weeb_number(week);
    
            status::Custom(Status::Ok, Json(json!({
                "status": 200,
                "result": program,
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


// #[get("/daily/video.mp4?<week>&<bloc>&<token>")]
// pub fn get_video_from_week_and_bloc(week: i32, bloc: i32, token: String) -> status::Custom<Option<NamedFile>> {
//     let decoded = decode_token(token);

//     if decoded.is_ok() {
//         // Valid token
//         let claims = decoded.unwrap().claims;
//         if claims.kind == "Access" {
//             //Access token is used
//             let asset = DailyProgram::get_asset_by_week_and_bloc(week, bloc);

//             if !asset.is_none() {
//                 status::Custom(Status::Ok, NamedFile::open(Path::new("assets/").join(asset.unwrap())).ok())
//             } else {
//                 //Video Not Found
//                 status::Custom(Status::NotFound, None)
//             }
//         } else { 
//             //Not an access token               
//         status::Custom(Status::Unauthorized, None)
//         }
//     } else {
//         //Invalid token
//         status::Custom(Status::Unauthorized, None)
//     }
// }