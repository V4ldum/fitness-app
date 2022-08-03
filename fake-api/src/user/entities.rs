use std::vec;

#[derive(Copy, Clone)]
pub enum Service {
    Daily,
    Other,
}


#[derive(Serialize, Clone)] 
pub struct User {
    pub username: String,
    pub full_name: String,
    pub permissions: Vec<i32>,
}

impl User {
    pub fn get_user_by_username(username: String) -> Option<User> {
        if username == "full" {
            //User 1
            Some(User {
                username: "full".to_string(),
                full_name: "Admin User".to_string(),
                permissions: vec![Service::Daily as i32, Service::Other as i32],
        })
        } else if username == "test" {
            //User 2
            Some(User {
                username: "test".to_string(),
                full_name: "Cat Bumstead".to_string(),
                permissions: vec![Service::Daily as i32],
        })
        } else if username == "none" {
            //User 3
            Some(User {
                username: "none".to_string(),
                full_name: "No Permissions".to_string(),
                permissions: vec![],
        })
        } else {
            //User not found
            None
        }
    }

    pub fn get_user_by_username_password(username: String, password: String) -> Option<User> {
        if username == "full" && password == "full" {
            //User 1
            Some(User {
                username: "full".to_string(),
                full_name: "Admin User".to_string(),
                permissions: vec![Service::Daily as i32, Service::Other as i32],
        })
        } else if username == "test" && password == "test" {
            //User 2
            Some(User {
                username: "test".to_string(),
                full_name: "Cat Bumstead".to_string(),
                permissions: vec![Service::Daily as i32],
        })
        } else if username == "none" && password == "none" {
            //User 3
            Some(User {
                username: "none".to_string(),
                full_name: "No Permissions".to_string(),
                permissions: vec![],
        })
        } else {
            //User not found
            None
        }
    }

    pub fn get_user_picture(username: String) -> Option<String> {
        if username == "test" {
            Some("strong_cat.png".to_string())
        } else {
            None
        }
    }
}

#[derive(Serialize)]
pub struct Comment {
    pub id: i32,
    pub user_id: String,
    pub content: String,
}

#[derive(Deserialize, Serialize)]
pub struct Claims {
    pub username: String,
    pub exp: usize,
    pub kind: String,
    pub permissions: Vec<i32>
}