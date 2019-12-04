//
//  UIFontExtension.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 3/11/18.
//  Copyright © 2018 Anteneh Sahledengel. All rights reserved.
//

import UIKit

// Replace the following with your font names
enum AppFontName: String {
    case regular = "BentonSans"
    case book = "BentonSans-Book"
    case bold = "BentonSans-Bold"
    case black = "BentonSans-Black"
    case medium = "BentonSans-Medium"
    case light = "BentonSans-Light"
    case thin = "BentonSans-Thin"
    case italic = "BentonSans-Italic"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

public extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold.rawValue, size: size)!
    }
    
    @objc class func mySemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: size)!
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic.rawValue, size: size)!
    }
    
    @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light.rawValue, size: size)!
    }
    
    @objc class func myThinSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.thin.rawValue, size: size)!
    }
    
    @objc class func myBlackSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.black.rawValue, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = AppFontName.regular.rawValue
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFontName.bold.rawValue
                case "CTFontHeavyUsage":
                    fontName = AppFontName.black.rawValue
                case "CTFontObliqueUsage":
                    fontName = AppFontName.regular.rawValue
                case "CTFontDemiUsage":
                    fontName = AppFontName.medium.rawValue
                default:
                    fontName = AppFontName.regular.rawValue
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }

    /// Call this to replace all system fonts in the app with custom ones. 
    class func overrideInitialize() {
        if self == UIFont.self {

            // Swizzle system intializers with custom initializers.
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}

