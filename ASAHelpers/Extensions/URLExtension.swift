//
//  URLExtension.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 5/2/17.
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

extension URL {
    public var fileName: String {
        let path = self.absoluteString
        let parts = path.components(separatedBy: "/")
        return parts.last!
    }
}
