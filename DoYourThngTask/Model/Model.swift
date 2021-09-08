//
//  Model.swift
//  DoYourThngTask
//
//  Created by Work Station 2 on 08/09/21.
//

import Foundation

//let BASE_URL = "https://newsapi.org/v2/top-headlines?ountry=us&apiKey=fc2d064353e04567b42a87d43460e97c"
    
  let BASE_URL = "https://newsapi.org/v2/top-headlines?country=in&apiKey=fc2d064353e04567b42a87d43460e97c"


class UserData {
    
    var title = ""
    var desc = ""
    var todayDate = ""
    var imgVw = ""
    init(json:[String:Any]) {
        
        self.title = json["title"] as? String ?? ""
        self.desc = json["description"] as? String ?? ""
        self.todayDate = json["publishedAt"] as? String ?? ""
        self.imgVw = json["urlToImage"] as? String ?? ""

       
   }
}

class News {
    var title = ""
    var desc = ""
    var todayDate = ""
    var imgVw = ""
    init(todayDate:String,title:String,desc:String,imgVw:String) {
        self.title = title
        self.desc = desc
        self.todayDate = todayDate
        self.imgVw = imgVw
        
        
    }
}
