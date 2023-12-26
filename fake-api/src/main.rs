
#![feature(decl_macro, proc_macro_hygiene)]
#![allow(proc_macro_derive_resolution_fallback, unused_attributes)]

extern crate dotenv;
extern crate r2d2;
#[macro_use]
extern crate rocket;
extern crate rocket_contrib;
#[macro_use]
extern crate serde_derive;
#[macro_use]
extern crate serde_json;

use dotenv::dotenv;
use std::process::Command;

mod drivers;

mod health;
mod user;
mod programs;
mod comments;

use user::routes as userRoutes;
use health::routes as healthRoutes;
use programs::routes as programRoutes;
use comments::routes as commentRoutes;

fn rocket() -> rocket::Rocket {
    dotenv().ok();

    rocket::ignite()
        .mount(
            "/",
            routes![
                healthRoutes::status,  
                userRoutes::authenticate_with_credentials, 
                userRoutes::authenticate_with_token,
                userRoutes::refresh_token,
                userRoutes::get_user_picture,
                userRoutes::get_picture_from_username,
                programRoutes::get_daily_program_from_week,
                commentRoutes::get_comment_from_week_and_day,
                commentRoutes::get_comment_from_id,
                commentRoutes::get_replies_from_id,
            ],
        )
}

fn main() {
    let _output = if cfg!(target_os = "windows") {
        Command::new("cmd")
            .args(&["/C", "cd ui && npm start"])
            .spawn()
            .expect("Failed to start UI Application")
    } else {
        Command::new("sh")
            .arg("-c")
            .arg("cd ui && npm start")
            .spawn()
            .expect("Failed to start UI Application")
    };
    rocket().launch();
}
