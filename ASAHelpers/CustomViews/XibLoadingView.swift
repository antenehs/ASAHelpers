//
//  XibLoadingView.swift
//
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

public class XibLoadingView: UIView {
    @IBInspectable var xibName: String!
    
    public lazy var view: UIView = self.createView()

    private func createView() -> UIView {
        let view = Bundle.main.loadNibNamed(self.xibName, owner: nil, options: nil)?[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupWithXibName(xibName: self.xibName)
    }
    
    func setupWithXibName(xibName: String) {
        self.xibName = xibName
        self.backgroundColor = UIColor.clear
        self.addSubview(self.view)
        self.addConstraints(NSLayoutConstraint.fillSuperviewConstraints(view: view))
        
        self.updateConstraints()
    }
}
