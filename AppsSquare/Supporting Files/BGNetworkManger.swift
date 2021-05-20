//
//  BGNetworkManger.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import UIKit
import Alamofire
import SwiftyJSON


class BGNetworkManger : NSObject {
    
    var container:UIView!
    
    private func checkInternet(_ vc: UIViewController) -> Bool{
        if BGNetworkHelper.noNetwork() {
            BGAlertPresenter.displayAlert(title: "sorry", message: "No Connection", doneBtn: "ok", forController: vc)
            return false
        }
        return true
    }
    
    
    func Post(controller:UIViewController,url:String,parameters:Parameters,showLoading:Bool = true){
        // check internet Connection
        guard checkInternet(controller) else {return}
        print(parameters, "<< sended parameters")
        // show loading if needed
        if showLoading {
            BGLoading.showLoading(controller.view)
        }
        // get static headers
        let head = BGNetworkHeaders.getHeader()
        // start request
        Alamofire.request(url,method:.post,parameters:parameters,encoding:URLEncoding.default,headers:head).validate().responseJSON { (response ) in
            // validate response result
            // guard response.result.value != nil else  { return }
            print("POST REQUEST STATUSCODE --> ",response.response?.statusCode ?? 0 ,"/nPOST REQUEST ERROR --> ",response.error ?? "no error found" , "/nPOST REQUEST URL -->  ",url)
            // hide loading if needed
            if showLoading {
                BGLoading.dismissLoading()
            }
            // handle response
            if BGNetworkHelper.validateResponse(controller: controller, response: response){
                print("data validated succesfully")
                print(response.result.value!)
                self.success(data: JSON(response.result.value!))
            }
        }
    }
    func success(data:JSON){
        print("Success data: \(data)")
        
    }
    
    func fail(data:JSON){
        
    }
}

class BGNetworkHeaders
{
    static func getHeader() -> HTTPHeaders {
        var header = ["Accept":"application/json"]
        if let token = UserDefaults.standard.value(forKey: "token") as? String{
            header["Authorization"] = "Bearer \(token)"
        }
        return header
    }
}


