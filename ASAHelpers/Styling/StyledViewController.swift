//
//  StyledViewController.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 2/11/18.
//  Copyright © 2018 Anteneh Sahledengel. All rights reserved.
//

import UIKit

open class StyledViewController: UIViewController {

    var screenName: String = ""

    override open func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem?.title = ""
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setupStyle),
                                               name: .appThemeDidChange,
                                               object: nil)
        
        setupStyle()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc open func setupStyle() {
        self.navigationController?.navigationBar.applyGlobalStyle()
        self.tabBarController?.tabBar.applyGlobalStyle()
        
        view.backgroundColor = Styling.theme.viewBackgroundColor
    }
}
