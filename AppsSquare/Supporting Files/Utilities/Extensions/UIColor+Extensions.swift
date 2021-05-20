//
//  UIColor+Extensions.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import UIKit
extension UIColor {
    
    convenience init(hex: String) {
       
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgbValue & 0x0000FF) / 255.0
            
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }

}
