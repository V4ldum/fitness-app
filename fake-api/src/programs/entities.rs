

#[derive(Serialize)]
pub struct DailyProgram {
    pub week_number: i32,
    pub data: String,
}

impl DailyProgram {
    pub fn get_program_by_weeb_number(week_number: i32) -> Option<DailyProgram> {
        if week_number % 2 == 0 {
            Some(DailyProgram {
                week_number,
                data: r##"[{"title":"Lundi","subtitle":"Lower Body","nb_comments":5,"blocs":[{"type":3,"details":{"sets":3,"rest_duration":{"min":1},"work_duration":{"sec":30},"cap_duration":{"min":2,"sec":30}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Power Clean x1"},{"name":"Clean x1"},{"name":"Power Squat Clean x1"},{"name":"Pause Squat x1"},{"name":"High Jump Squat x3"}]},{"type":3,"details":{"work_duration":{"min":2},"cap_duration":{"min":12}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"*0-2': Squat Clean x8"},{"name":"*2-4': Fentes x8/côté"},{"name":"*4-6': Romanian Deadlift x10 + Jump Squat x10 + Abdos x10"}]},{"type":4,"details":{"sets":3,"pause_duration":{"min":1},"work_duration":{"sec":20},"rest_duration":{"sec":10}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Burpees"},{"name":"Goblet Squat Clean"},{"name":"Rack Walk"},{"name":"Swing"},{"name":"Jumping Jack"},{"name":"Farmer Walk"}]}]},{"title":"Mardi","subtitle":"Upper Body","blocs":[{"type":1,"details":{"sets":3,"cap_duration":{"min":2},"rest_duration":{"min":1}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Over Head Press x5/côté"},{"name":"Rowing Sumo x5/côté"}]},{"type":2,"details":{"cap_duration":{"min":15}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Tractions x50"},{"name":"Pompes Inclinées Lestées x50"},{"name":"American Swing x50"}]}]},{"title":"Mercredi","subtitle":"Repos","text":"Retrouve chaque semaine tes entraînements en vidéo!"},{"title":"Jeudi","subtitle":"Lower Body","blocs":[{"type":0,"details":{"sets":3,"rest_duration":{"min":2}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Squat x6"},{"name":"Deadlift x6"}]},{"type":1,"details":{"sets":4,"cap_duration":{"min":2},"rest_duration":{"min":1}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Romanian Deadlift x10"},{"name":"Toes to Bar x10"}]},{"type":1,"details":{"sets":4,"cap_duration":{"min":2},"rest_duration":{"sec":30}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Jump Squat x5"},{"name":"Jumping Jack x15"},{"name":"Mountain Climber x30"}]}]},{"title":"Vendredi","subtitle":"Upper Body","blocs":[{"type":3,"details":{"work_duration":{"min":2,"sec":30},"cap_duration":{"min":10}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Over Head Press x6"},{"name":"Tractions Lestées x6"},{"name":"Toes to Bar x6"}]},{"type":3,"details":{"work_duration":{"min":2,"sec":30},"cap_duration":{"min":10}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Floor Press x8"},{"name":"Rowing Sumox8"},{"name":"Knee Raises x8"}]},{"type":2,"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Oiseau x30"},{"name":"Upright Row x30"},{"name":"Burpees x30"},{"name":"Swing x30"},{"name":"Jumping Jack x30"},{"name":"Farmer Walk x30"}]}]}]"##.to_string(),
            })
        } else {
            Some(DailyProgram {
                week_number,
                data: r##"[{"title":"Lundi","subtitle":"Full Body","nb_comments":5,"blocs":[{"type":3,"details":{"work_duration":{"min":2},"cap_duration":{"min":10}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Power Clean x1"},{"name":"Clean x1"},{"name":"Power Squat Clean x1"},{"name":"Pause Squat x1"},{"name":"High Jump Squat x3"}]},{"type":3,"details":{"work_duration":{"min":2},"cap_duration":{"min":12}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"*0-2': Squat Clean x8"},{"name":"*2-4': Fentes x8/côté"},{"name":"*4-6': Romanian Deadlift x10 + Jump Squat x10 + Abdos x10"}]},{"type":4,"details":{"sets":3,"pause_duration":{"min":1},"work_duration":{"sec":20},"rest_duration":{"sec":10}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Burpees x30"},{"name":"Goblet Squat Clean x30"},{"name":"Rack Walk x30"},{"name":"Swing x30"},{"name":"Jumping Jack"},{"name":"Farmer Walk"}]}]},{"title":"Mardi","subtitle":"Repos","text":"Retrouve chaque semaine tes entraînements en vidéo!"},{"title":"Mercredi","subtitle":"Full Body","blocs":[{"type":1,"details":{"sets":3,"cap_duration":{"min":2},"rest_duration":{"min":1}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Over Head Press x5/côté"},{"name":"Rowing Sumo x5/côté"}]},{"type":2,"details":{"cap_duration":{"min":15}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Tractions x50"},{"name":"Pompes Inclinées Lestées x50"},{"name":"American Swing x50"}]}]},{"title":"Jeudi","subtitle":"Repos","text":"Retrouve chaque semaine tes entraînements en vidéo!"},{"title":"Vendredi","subtitle":"Upper Body","blocs":[{"type":3,"details":{"work_duration":{"min":2,"sec":30},"cap_duration":{"min":10}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Over Head Press x6"},{"name":"Tractions Lestées x6"},{"name":"Toes to Bar x6"}]},{"type":3,"details":{"work_duration":{"min":2,"sec":30},"cap_duration":{"min":10}},"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Floor Press x8"},{"name":"Rowing Sumox8"},{"name":"Knee Raises x8"}]},{"type":2,"video":"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4","exercises":[{"name":"Oiseau x30"},{"name":"Upright Row x30"},{"name":"Burpees x30"},{"name":"Swing x30"},{"name":"Jumping Jack x30"},{"name":"Farmer Walk x30"}]}]}]"##.to_string(),
            })
        }
    }

    // pub fn get_asset_by_week_and_bloc(_week_number: i32, bloc_number: i32) -> Option<String>  { //TODO autre type? 
    //     if bloc_number == 1 {
    //         Some("video1.mp4".to_string())
    //     } else if bloc_number == 2 {
    //         Some("video2.mp4".to_string())
    //     } else if bloc_number == 3 {
    //         Some("video2.mp4".to_string())
    //     } else {
    //         None
    //     }
    // }
}