//
//  Constants.swift
//  
//
//  Created by Basem El-Gendy on 3/4/18.
//  Copyright © 2018 Basem El-Gendy. All rights reserved.
//


import Foundation

class BGConstants: NSObject {
    
    // MARK: - Network response status
    static var errorMark: String {return ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"}
    static var success:Int {return 200}
    static var failed:Int {return 400}
    static var created:Int {return 201}
    static var unauthenticated:Int {return 401}
    static var unprocessableEntity : Int {return 422}
    // MARK: - APIs Constants
    
    static var apiURL:String {return "https://cut-backend-2.appssquare.com/api"}
    

}
