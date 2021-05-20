//
//  String+Extensions.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import Foundation
extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func isvalidPassword() -> Bool{
        if self.count >= 8{
            return true
        }
        else{
            return false
        }
    }
}
