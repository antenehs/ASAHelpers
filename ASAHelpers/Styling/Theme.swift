//
//  Theme.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 2/24/18.
//  Copyright © 2018 Anteneh Sahledengel. All rights reserved.
//

import UIKit

public enum ThemeType: String {
    case light
    case dark
    case night

    var theme: Theme {
        switch self {
        case .light: return LightTheme()
        case .dark: return DarkTheme()
        case .night: return NightTheme()
        }
    }
}

public protocol Theme {
    
    static var themeType: ThemeType { get }
    
    var globalTintColor: UIColor { get }
    
    var titleLabelColor: UIColor { get }
    var subtitleLabelColor: UIColor { get }
    var descriptionLabelColor: UIColor { get }
    
    var cellSeparatorColor: UIColor { get }
    var cellBackgroundColor: UIColor { get }
    var viewBackgroundColor: UIColor { get }
    
    var buttonTextColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
    
    var iconTintColor: UIColor { get }
    
    var navigationBarStyle: UIBarStyle { get }
    var naviagationBarTintColor: UIColor { get }
    var naviagationBarTitleColor: UIColor { get }
    var tabBarStyle: UIBarStyle { get }
    var tabBarTintColor: UIColor { get }
    var tabBarSelectedItemColor: UIColor { get }
    var tabBarItemColor: UIColor { get }
}

public class LightTheme: Theme {
    
    public static let themeType: ThemeType = .light

    public let globalTintColor: UIColor = .appTintColor
    
    public let titleLabelColor: UIColor = .black
    
    public let subtitleLabelColor: UIColor = .lightGray
    
    public let descriptionLabelColor: UIColor = .lightGray
    
    public let cellSeparatorColor: UIColor = .lightGray
    
    public let cellBackgroundColor: UIColor = .white
    
    public let viewBackgroundColor: UIColor = .appAlmostWhite
    
    public let buttonTextColor: UIColor = .white
    
    public let buttonBackgroundColor: UIColor = .appTintColor
    
    public let iconTintColor: UIColor = .black
    
    public let navigationBarStyle: UIBarStyle = .default
    
    public let naviagationBarTintColor: UIColor = .appTintColor
    
    public let naviagationBarTitleColor: UIColor = .black
    
    public let tabBarStyle: UIBarStyle = .default
    
    public let tabBarTintColor: UIColor = .appTintColor
    
    public let tabBarSelectedItemColor: UIColor = .appAlmostBlack
    
    public let tabBarItemColor: UIColor = .lightGray

    public init() {}
}

public class DarkTheme: Theme {
    
    public static let themeType: ThemeType = .dark
    
    public let globalTintColor: UIColor = .appTintColor
    
    public let titleLabelColor: UIColor = .white
    
    public let subtitleLabelColor: UIColor = .lightGray
    
    public let descriptionLabelColor: UIColor = .lightGray
    
    public let cellSeparatorColor: UIColor = .darkGray
    
    public let cellBackgroundColor: UIColor = .appAlmostBlack
    
    public let viewBackgroundColor: UIColor = .appBackgroundBlack
    
    public let buttonTextColor: UIColor = .white
    
    public let buttonBackgroundColor: UIColor = .appTintColor
    
    public let iconTintColor: UIColor = .white
    
    public let navigationBarStyle: UIBarStyle = .black
    
    public let naviagationBarTintColor: UIColor = .appTintColor
    
    public let naviagationBarTitleColor: UIColor = .white
    
    public let tabBarStyle: UIBarStyle = .black
    
    public let tabBarTintColor: UIColor = .appTintColor
    
    public let tabBarSelectedItemColor: UIColor = .appAlmostWhite
    
    public let tabBarItemColor: UIColor = .lightGray

    public init() {}
}

public class NightTheme: Theme {

    public static let themeType: ThemeType = .night

    public let globalTintColor: UIColor = .appTintColor

    public let titleLabelColor: UIColor = UIColor(white: 0.9, alpha: 1)

    public let subtitleLabelColor: UIColor = .lightGray

    public let descriptionLabelColor: UIColor = .lightGray

    public let cellSeparatorColor: UIColor = .darkGray

    public let cellBackgroundColor: UIColor = .appMidNightBlueColor

    public let viewBackgroundColor: UIColor = .appMidNightDarkBlueColor

    public let buttonTextColor: UIColor = .white

    public let buttonBackgroundColor: UIColor = .appTintColor

    public let iconTintColor: UIColor = .white

    public let navigationBarStyle: UIBarStyle = .black

    public let naviagationBarTintColor: UIColor = .appTintColor

    public let naviagationBarTitleColor: UIColor = .white

    public let tabBarStyle: UIBarStyle = .black

    public let tabBarTintColor: UIColor = .appTintColor

    public let tabBarSelectedItemColor: UIColor = .appAlmostWhite

    public let tabBarItemColor: UIColor = .lightGray

    public init() {}
}
