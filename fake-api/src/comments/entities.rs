use std::vec;

#[derive(Serialize, Clone)]
pub struct Comment {
    pub id: i32,
    pub username: String,
    pub display_name: String,
    pub message: String,
    pub timestamp: u32,
    pub nb_replies: u32,
}

impl Comment {
    pub fn get_comments_by_week_and_day(_week: i32, day: i32) -> Option<Vec<Comment>> {
        if day == 0 {
            Some(vec![    
                Comment {
                    id: 1,
                    username: "test".to_string(), 
                    display_name: "Cat Bumstead".to_string(),
                    message: "Le bloc 1 est compliqué ?".to_string(),
                    timestamp: 1658842775,
                    nb_replies: 2,
                },  
                Comment {
                    id: 2,
                    username: "full".to_string(), 
                    display_name: "Admin User".to_string(),
                    message: "Trop cool ce programme".to_string(),
                    timestamp: 1658843775,
                    nb_replies: 0,
                },    
                Comment {
                    id: 3,
                    username: "none".to_string(), 
                    display_name: "No Permissions".to_string(),
                    message: "J'ai fais le bloc 1 en 7:32".to_string(),
                    timestamp: 1658670975,
                    nb_replies: 0,
                },   
            ])
        } else {
            None
        }
    }
    pub fn get_comment_by_id(id: i32) -> Option<Comment> {
        if id == 1 {
            Some(Comment {
                id: 1,
                    username: "test".to_string(), 
                    display_name: "Cat Bumstead".to_string(),
                    message: "Le bloc 1 est compliqué ?".to_string(),
                    timestamp: 1658842775,
                    nb_replies: 2,
            })
        } else {

            None
        }
    }
}

#[derive(Serialize, Clone)]
pub struct Reply {
    pub username: String,
    pub display_name: String,
    pub message: String,
    pub timestamp: i32,
}

impl Reply {
    pub fn get_reply_from_comment_id(id: i32) -> Option<Vec<Reply>> {
        if id == 1 {
            Some(vec![
                Reply { 
                    username: "none".to_string(), 
                    display_name: "No Permissions".to_string(),
                    message: "Non il est pas trop dur".to_string(),
                    timestamp: 1658852775
                },
                Reply { 
                    username: "full".to_string(), 
                    display_name: "Admin User".to_string(),
                    message: "Moi j'ai eu un peu de mal".to_string(),
                    timestamp: 1658862775
                }
            ])
        } else {
            None
        }
    }
}