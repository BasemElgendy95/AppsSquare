//
//  UINavigation+Extensions.swift
//  Fajr-Teacher
//
//  Created by BasemElgendy on 01/03/2020.
//  Copyright © 2020 BasemElgendy. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func hideBackground(){
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    func showBackground(){
        self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationBar.shadowImage = nil
        self.navigationBar.isTranslucent = false
    }
}
