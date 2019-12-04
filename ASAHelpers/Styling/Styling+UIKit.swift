//
//  Styling+UIKit.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 2/25/18.
//  Copyright © 2018 Anteneh Sahledengel. All rights reserved.
//

import UIKit

public extension UILabel {
    @IBInspectable var styleIdentifier: String? {
        get {
            fatalError("Shouldn't read this property: UILabel styleIdentifier")
        }
        set {
            if let identifier = newValue {
                if let style = LabelStyle(rawValue: identifier) {
                    applyStyle(style)
                } else {
                    print("WARNING: Did not find styling identifier \"\(identifier)\". Make sure it is spelled correctly")
                }
            }
        }
    }
    
    func applyStyle(_ style: LabelStyle) {
        self.textColor = style.color
    }
}

public extension UITableView {
    func applyGlobalStyle() {
        self.backgroundColor = Styling.theme.viewBackgroundColor
        self.separatorColor = Styling.theme.cellSeparatorColor
    }
}

public extension UITableViewCell {
    
    func applyGlobalStyle() {
        tintColor = Styling.theme.globalTintColor
        textLabel?.applyStyle(.nameLabel)
        detailTextLabel?.applyStyle(.detailDescription)
        backgroundColor = Styling.theme.cellBackgroundColor
        contentView.backgroundColor = Styling.theme.cellBackgroundColor
    }
}

public extension UIImageView {
    
    func applyGlobalIconStyle() {
        self.tintColor = Styling.theme.iconTintColor
    }
}

public extension UISwitch {
    
    func applyGlobalStyle() {
        self.tintColor = Styling.theme.globalTintColor
    }
}

public extension UINavigationBar {
    func applyGlobalStyle() {
        self.barStyle = Styling.theme.navigationBarStyle
        self.tintColor = Styling.theme.naviagationBarTintColor
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Styling.theme.naviagationBarTitleColor]
    }
}

public extension UITabBar {
    func applyGlobalStyle() {
        self.barStyle = Styling.theme.tabBarStyle
        self.tintColor = Styling.theme.tabBarSelectedItemColor
        self.unselectedItemTintColor = Styling.theme.tabBarItemColor
    }
}
