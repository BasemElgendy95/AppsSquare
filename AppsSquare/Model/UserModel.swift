//
//  UserModel.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import Foundation


struct UserModel : Codable {
    
    let id : Int?
    let fullName : String?
    let email : String?
    let phone : String?
    let status : Int?
    let role : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "fullName"
        case email = "email"
        case phone = "phone"
        case status = "status"
        case role = "role"
    }
           
}
