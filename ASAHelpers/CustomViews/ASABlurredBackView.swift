//
//  BlurredBackView.swift
//  EmojiKeyboard
//
//  Created by Anteneh Sahledengel on 5/1/17.
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

//@IBDesignable
open class ASABlurredBackView: UIView {
    
    @IBInspectable public var blurStyleString: String? {
        didSet {
            if let style = UIBlurEffect.Style.initFrom(string: blurStyleString ?? "") {
                blurStyle = style
            }
        }
    }
    
    public var blurStyle: UIBlurEffect.Style = .light {
        didSet {
            configureView()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    func configureView() {
        self.backgroundColor = .clear
        self.alpha = 1
        
        self.asa_addBlurredBackground(withStyle: blurStyle)
    }

}

extension UIBlurEffect.Style {
    static func initFrom(string: String) -> UIBlurEffect.Style? {
        switch string {
        case "extraLight":
            return .extraLight
        case "light":
            return .light
        case "dark":
            return .dark
        case "regular":
            if #available(iOS 10.0, *) {
                return .regular
            } else {
                return nil
            }
        case "prominent":
            if #available(iOS 10.0, *) {
                return .prominent
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}



