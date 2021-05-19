//
//  BGLabel.swift
//  BGSetup
//
//  Created by Basem Elgendy on 2/9/19.
//  Copyright © 2019 Basem Elgendy. All rights reserved.
//

import UIKit

@IBDesignable
open class BGLabel : UILabel {
    
    /**
     An enum that defines the types of `BGLabel` style
     
     - header: Shows the heavy text.
     - title: Shows the medium text.
     - regular: Shows the regular text.
     - body: Shows the thin text.

     */
    public enum LabelType : String{
        case title
        case body
        case header
        case regular
    }
    
    
    class var shared: BGLabel {
        struct Static {
            static let instance = BGLabel()
        }
        return Static.instance
    }
    
    var labelType = LabelType.regular
    static var headerFont : UIFont = UIFont.systemFont(ofSize: 30, weight: .heavy)
    static var titleFont : UIFont = UIFont.systemFont(ofSize: 20, weight: .medium)
    static var regularFont : UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    static var bodyFont : UIFont = UIFont.systemFont(ofSize: 15, weight: .thin)
    
    @IBInspectable private var fontType : String {
        set {
            labelType = LabelType(rawValue: newValue) ?? .regular
            setFont()
        }
        get {
            return labelType.rawValue
        }
    }

    static func setFonts(fontName: String , headerSize : CGFloat , titleSize : CGFloat, regularSize : CGFloat , bodySize : CGFloat ){
        BGLabel.headerFont  = UIFont(name: fontName + "-black", size: headerSize)!
        BGLabel.titleFont  = UIFont(name: fontName + "-semibold", size: titleSize)!
        BGLabel.regularFont  = UIFont(name: fontName + "-regular", size: regularSize)!
        BGLabel.bodyFont  = UIFont(name: fontName + "-light", size: bodySize)!
    }
    

    private func setFont(){
        switch labelType {
        case .body:
            self.font = BGLabel.bodyFont
        case .title:
            self.font = BGLabel.titleFont
        case .header:
            self.font = BGLabel.headerFont
        default:
            self.font = BGLabel.regularFont
        }
        
    }
    
  
    
}

