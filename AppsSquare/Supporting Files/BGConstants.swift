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
    static var notAcceptable : Int {return 406}
    // MARK: - APIs Constants
    
    static var cometAppId:String {return "29227e14202eb08"}
    static var cometAppKey:String {return "e0c227ef24ca925a6117ccb440d3f7c14bac6f74"}
    static var cometRegion:String {return "eu"}
    static var baseURL:String {return "https://telemed.jazanu.edu.sa/"}
    static var apiURL:String {return "\(baseURL)api/" + acceptedVersion}
    static var imagesURL:String {return baseURL + "storage/"}
    static var acceptedVersion:String {return "v1.0"}
    

}
