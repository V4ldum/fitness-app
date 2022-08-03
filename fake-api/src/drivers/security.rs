use chrono::{Duration, Utc};
use jsonwebtoken::{encode, decode, EncodingKey, DecodingKey, Header, Validation, TokenData, errors::Error};
use super::super::user::entities::{User, Claims};


pub fn get_secret() -> Vec<u8> {
    std::env::var("JWT_SECRET").unwrap().into_bytes()
}

pub fn get_access_token(user: &User) -> String {
    let expiration_time = Utc::now()
        .checked_add_signed(Duration::days(7))
        .expect("invalid timestamp")
        .timestamp();
    let user_claims = Claims {
        username: user.username.clone(),
        exp: expiration_time as usize,
        kind: "Access".to_string(),
        permissions: user.permissions.clone(),
    };
    let token = match encode(
        &Header::default(),
        &user_claims,
        &EncodingKey::from_secret(&get_secret()),
    ) {
        Ok(t) => t,
        Err(_) => panic!(),
    };
    token
}

pub fn get_refresh_token(user: &User) -> String {
    let expiration_time = Utc::now()
        .checked_add_signed(Duration::days(30))
        .expect("invalid timestamp")
        .timestamp();
    let user_claims = Claims {
        username: user.username.clone(),
        exp: expiration_time as usize,
        kind: "Refresh".to_string(),
        permissions: user.permissions.clone(),
    };
    let token = match encode(
        &Header::default(),
        &user_claims,
        &EncodingKey::from_secret(&get_secret()),
    ) {
        Ok(t) => t,
        Err(_) => panic!(),
    };
    token
}

pub fn decode_token(token: String) -> Result<TokenData<Claims>, Error> {
    decode::<Claims>(
        &token,
        &DecodingKey::from_secret(&get_secret()),
        &Validation::default(),
    )
}