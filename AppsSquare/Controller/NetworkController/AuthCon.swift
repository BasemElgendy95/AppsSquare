//
//  AuthCon.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import Foundation
import Foundation
import Alamofire
import SwiftyJSON


class AuthCon:BGNetworkManger{
    
    weak var con: UIViewController!
    
    func login(_ controller:UIViewController,parameters:[String:Any]) {
        con = controller
        super.Post(controller: controller, url: BGEndpoints.login, parameters: parameters)
    }
    override func success(data: JSON) {
        handelLoginSuccess(data)
    }
    fileprivate func handelLoginSuccess(_ data: JSON) {
        guard let loginVC = con as? LoginViewController else {return}
        do{
            let successData = try data["data"].rawData()
            let token = data["token"].stringValue
            UserDefaults.standard.set(token, forKey: "token")
            let decoder = JSONDecoder()
            let user = try decoder.decode(UserModel.self, from: successData)
            self.saveUserLocal(codes: user)
            loginVC.successLogin(user: user)
            
        }catch{
            print(error.localizedDescription , "Error in decoding")
        }
    }
    
    func saveUserLocal(codes: UserModel){
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(codes) else {return}
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "user")
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
    
    static func getSavedUser() -> UserModel?{
        let defaults = UserDefaults.standard
        guard let savedUser = defaults.object(forKey: "user") as? Data else {return nil}
        let decoder = JSONDecoder()
        guard let loadedUser = try? decoder.decode(UserModel.self, from: savedUser) else{return nil}
        return loadedUser
    }
}
