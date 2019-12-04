//
//  UIColorExtension.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 5/4/17.
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    public static var appLightGreen: UIColor {
        return UIColor(rgb: 0x5fca9d)
    }

    public static var appGreen: UIColor {
        return UIColor(rgb: 0x00CC66)
    }

    public static var appLime: UIColor {
        return UIColor(rgb: 0x1ABC9C)
    }

    public static var appYellow: UIColor {
        return UIColor(rgb: 0xFCBC19)
    }

    public static var appPink: UIColor {
        return UIColor(rgb: 0xFF2D55)
    }

    public static var appRed: UIColor {
        return UIColor(rgb: 0xE74C3C)
    }

    public static var appPurple: UIColor {
        return UIColor(rgb: 0x9B59B6)
    }

    public static var appBackgroundBlack: UIColor {
        return UIColor(rgb: 0x171717)
    }

    public static var appAlmostBlack: UIColor {
        return UIColor(rgb: 0x1c1c1d)
    }

    public static var appAlmostBlackBlue: UIColor {
        return UIColor(rgb: 0x343b3e)
    }

    public static var appAlmostWhite: UIColor {
        return UIColor(rgb: 0xf2f2f3)
    }

    public static var appTintColor: UIColor {
        return UIColor.appGreen
    }

    public static var appMidNightBlueColor: UIColor {
        return UIColor(rgb: 0x353c48)
    }

    public static var appMidNightDarkBlueColor: UIColor {
        return UIColor(rgb: 0x232930)
    }
}
