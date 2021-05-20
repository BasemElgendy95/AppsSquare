//
//  BGNetworkHelper.swift
//  JAZAN-UNI
//
//  Created by BasemElgendy on 01/06/2020.
//  Copyright © 2020 BasemElgendy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration

class BGNetworkHelper {
    
    static func noNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return !(isReachable && !needsConnection)
    }
    
   static func validateResponse (controller: UIViewController, response:DataResponse<Any>) ->Bool{
    let json = JSON(response.data!)
    print(json)
        switch response.result {
        case .success:
            switch response.response?.statusCode {
            case BGConstants.success?:
                return true
            case BGConstants.created?:
                return true
            case BGConstants.unprocessableEntity?:
                var message = "please check \n"
                if let email = json["data"]["email"].arrayValue.first {
                    message.append(email.stringValue + "\n")
                }
                if let password = json["data"]["password"].arrayValue.first {
                    message.append(password.stringValue + "\n")
                }
                if let phone = json["data"]["phone.number"].arrayValue.first {
                    message.append(phone.stringValue + "\n")
                }
                BGAlertPresenter.displayAlert(title: json["message"].stringValue, message:message,doneBtn:"done",forController:controller)
                return false
            default:
                return false
            }
        
        
        case .failure:
            switch response.response?.statusCode {
            case BGConstants.unprocessableEntity? :
                var message = "please check \n"
                if let email = json["errors"]["email"].arrayValue.first {
                    message.append(email.stringValue + "\n")
                }
                if let phone = json["errors"]["phone.number"].arrayValue.first {
                    message.append(phone.stringValue + "\n")
                }
                BGAlertPresenter.displayAlert(title: json["message"].stringValue, message:message,doneBtn:"done",forController:controller)
            case BGConstants.unauthenticated?:
                var message = ""
                if let newMessage = json["Status"]["Description"].string { message = newMessage}
                if let newMessage = json["message"].string { message = newMessage}
                BGAlertPresenter.displayAlert(title: message, message:"",doneBtn:"done",forController:controller,completion: {
                })
                
            default:
            return false
            }
            
            return false
        }
    }
    
}
