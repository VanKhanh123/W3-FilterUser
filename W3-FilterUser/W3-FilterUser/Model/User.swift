//
//  User.swift
//  W3-FilterUser
//
//  Created by Văn Khánh Vương on 31/03/2021.
//

import Foundation

enum City: String {
    case HoChiMinh = "Ho Chi Minh"
    case DaNang = "Da Nang"
    case HaNoi = "Ha Noi"
}

class User {
    var userName: String?
    var gender: String
    var level: String
    var city: City
    init(cityName: City, userName: String, gender: String, level: String) {
        self.city = cityName
        self.userName = userName
        self.gender = gender
        self.level = level
        
    }
}
