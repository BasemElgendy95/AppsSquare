//
//  Loading.swift
//  
//
//  Created by Basem El-Gendy on 3/4/18.
//  Copyright © 2018 Basem El-Gendy. All rights reserved.
//

import UIKit
import JHSpinner

class BGLoading: NSObject {
    static var spinner:JHSpinnerView?
    
    static func dismissLoading(){
         DispatchQueue.main.async{
        if BGLoading.spinner != nil{
            BGLoading.spinner?.dismiss()
            }
        }
    }
    
    static func showLoading(_ view:UIView){
        DispatchQueue.main.async{
            if BGLoading.spinner != nil{
                BGLoading.spinner?.dismiss()
            }
            BGLoading.spinner = JHSpinnerView.showOnView(view, spinnerColor: UIColor.init(named: "ECAD3C"), overlay: .fullScreen, overlayColor: UIColor.black.withAlphaComponent(0.6), fullCycleTime: 4.0, text: "loading".locale, textColor: UIColor.white)
            view.addSubview(BGLoading.spinner!)
        }
        
    }

}


