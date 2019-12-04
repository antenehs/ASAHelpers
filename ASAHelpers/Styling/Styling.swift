//
//  AppearanceManager.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 2/11/18.
//  Copyright © 2018 Anteneh Sahledengel. All rights reserved.
//

import UIKit

public extension Notification.Name {
    static let appThemeDidChange = Notification.Name("AppThemeDidChange")
}

public enum LabelStyle: String {
    case header1 = "header1"
    case header2 = "header2"
    case header3 = "header3"
    case nameLabel = "nameLabel"
    case regular = "regular"
    case body = "body"
    case description = "description"
    case detailDescription = "detailDescription"
    
    public var color: UIColor {
        switch self {
        case .header1, .header2, .header3, .nameLabel, .regular:
            return Styling.theme.titleLabelColor
        case .body:
            return Styling.theme.subtitleLabelColor
        case .description, .detailDescription:
            return Styling.theme.descriptionLabelColor
        }
    }
}

public class Styling {
    public static let shared = Styling()

    public var currentThemeType: ThemeType = .light
    var theme: Theme { return currentThemeType.theme }

    private init() {}
    
    public func setTheme(_ themeType: ThemeType) {
        currentThemeType = themeType
        
        Styling.applyGlobalTheme()

        NotificationCenter.default.post(Notification(name: .appThemeDidChange))
    }
    
    public static func applyGlobalTheme() {
        // UISwitch
        UISwitch.appearance().tintColor = theme.globalTintColor
        UISwitch.appearance().onTintColor = theme.globalTintColor
    }
}


// MARK: Static accesssors
public extension Styling {
    static var theme: Theme { return self.shared.theme }
}
