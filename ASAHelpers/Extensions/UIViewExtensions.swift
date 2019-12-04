//
//  UIViewExtension.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 5/2/17.
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

public extension UIView {
    
    func asa_addBlurredBackground(withStyle style: UIBlurEffect.Style) {
        
        if let alreadyAdded = self.viewWithTag(19876) {
            alreadyAdded.removeFromSuperview()
        }
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 19876
        
        self.insertSubview(blurEffectView, at: 0)
        
    }
    
    func roundRect(withBorder: Bool) {
        if withBorder {
            roundRect(borderWidth: 2.0, borderColor: UIColor.black.cgColor)
        } else {
            roundRect(borderWidth: nil, borderColor: nil)
        }
    }
    
    func roundRect(borderWidth: CGFloat?, borderColor: CGColor?) {
        roundRect(cornerRadius: frame.height/2, borderWidth: borderWidth, borderColor: borderColor)
    }
    
    func roundRect(cornerRadius: CGFloat, borderWidth: CGFloat?, borderColor: CGColor?) {
        layer.borderWidth = borderWidth ?? 0
        
        if let borderColor = borderColor {
            layer.borderColor = borderColor
        }
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }

    static func asa_popAnimate(view: UIView,
                               withScale scale: CGFloat = 0.2,
                               completion: (() -> Void)? = nil) {

        let poppedScale = 1 + scale
        UIView.asa_springAnimate(withDuration: 0.2, animations: {
            view.transform = CGAffineTransform(scaleX: poppedScale, y: poppedScale)
        }, completion: { _ in
            UIView.asa_springAnimate(withDuration: 0.1, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { _ in
                completion?()
            })
        })
    }

    static func asa_springAnimate(withDuration duration: TimeInterval,
                                  delay: TimeInterval = 0,
                                  animations: @escaping (() -> Void),
                                  completion: ((Bool) -> Void)? = nil) {

        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: animations,
                       completion: completion)
    }
}
