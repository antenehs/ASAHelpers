//
//  JSONDecode+KeyPath.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 8/4/18.
//  Copyright © 2018 Anteneh Sahledengel. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String? = nil) throws -> T {
        
        guard let keyPath = keyPath else {
            return try decode(type, from: data)
        }
        
        let toplevel = try JSONSerialization.jsonObject(with: data)
        if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
            guard JSONSerialization.isValidJSONObject(nestedJson) else {
                throw DecodingError.dataCorrupted(.init(codingPath: [],
                                                        debugDescription: "Nested json is not valid json object, key path: \"\(keyPath)\""))
            }
            
            let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
            return try decode(type, from: nestedJsonData)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [],
                                                    debugDescription: "Nested json not found for key path \"\(keyPath)\""))
        }
    }
}
