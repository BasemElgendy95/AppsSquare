//
//  LoginViewController.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import UIKit

protocol AuthDelegate {
    func successLogin(user: UserModel)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordBtn: UIButton!

    var authDelegate : AuthDelegate?
    let authCon = AuthCon()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggelPasswordAction(){
        if passwordTF.isSecureTextEntry {
            passwordBtn.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
        }else{
            passwordBtn.setImage(#imageLiteral(resourceName: "show"), for: .normal)
        }
        passwordTF.isSecureTextEntry.toggle()
    }

    @IBAction func loginAction(){
        guard validateInput() else {return}
        authCon.login(self, parameters: [
                                        "email":emailTF.text ?? "" ,
                                        "password":passwordTF.text ?? ""
                                        ])
    }
    
    private func validateInput() -> Bool{
        emailView.borderColor = .clear
        passwordView.borderColor = .clear
        guard !(emailTF.text?.isEmpty)! else{
            emailView.borderColor = .red
            return false
        }
        guard (emailTF.text!.isValidEmail()) else {
            emailView.borderColor = .red
            return false
        }
        guard !(passwordTF.text?.isEmpty)! else{
            passwordView.borderColor = .red
            return false
        }
        guard (passwordTF.text!.isvalidPassword()) else {
            passwordView.borderColor = .red
            return false
        }
        return true
        
    }
}

extension LoginViewController {
    
    func successLogin(user: UserModel){
        
        self.dismiss(animated: true) {
            self.authDelegate?.successLogin(user: user)
        }
    }
}
