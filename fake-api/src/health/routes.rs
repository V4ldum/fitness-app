use rocket::response::status;
use rocket::http::Status;

#[get("/status", format="text/html")]
pub fn status() -> status::Custom<String> {
    status::Custom(Status::Ok, String::from("Works!"))
}