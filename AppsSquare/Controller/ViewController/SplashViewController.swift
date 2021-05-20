//
//  SplashViewController.swift
//  AppsSquare
//
//  Created by BasemElgendy on 19/05/2021.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.successVersion()
    }
   
    @objc private func navigationToHome(){
        DispatchQueue.main.async {
            let newViewController = self.viewController(fromStoryBoard:"Home", withIdentifier: "HomeNavigationController")
            let mySceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            mySceneDelegate.window?.rootViewController = newViewController
        }
    }
}

extension SplashViewController {
    func successVersion(){
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(navigationToHome), userInfo: nil, repeats: false)
    }
}

