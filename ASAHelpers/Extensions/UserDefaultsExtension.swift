//
//  UserDefaultsExtension.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 5/3/17.
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

open class UserDefaultKey {
    var name: String
    
    required public init(name: String) {
        self.name = name
    }
}

open class UserDefaultBoolKey: UserDefaultKey {}

open class UserDefaultStringKey: UserDefaultKey {}

open class UserDefaultIntKey: UserDefaultKey {}

open class UserDefaultDoubleKey: UserDefaultKey {}

open class UserDefaultDictionaryKey: UserDefaultKey {}

open class UserDefaultArrayKey: UserDefaultKey {}

open class UserDefaultDateKey: UserDefaultKey {}

protocol TypeReadable {}
extension UserDefaults: TypeReadable {
    public func read(key: UserDefaultBoolKey, defaultBoolValue: Bool = false) -> Bool {
        if let boolValue = object(forKey: key.name) as? Bool {
            return boolValue
        }
        
        return defaultBoolValue
    }
    
    public func read(key: UserDefaultStringKey) -> String? {
        return string(forKey: key.name)
    }
    
    public func read(key: UserDefaultIntKey) -> Int? {
        return integer(forKey: key.name)
    }
    
    public func read(key: UserDefaultDoubleKey) -> Double {
        return double(forKey: key.name)
    }
    
    public func read(key: UserDefaultArrayKey) -> [String]? {
        return object(forKey: key.name) as? [String]
    }
    
    public func read(key: UserDefaultDictionaryKey) -> [String: AnyObject]? {
        return object(forKey: key.name) as? [String: AnyObject]
    }
    
    public func read(key: UserDefaultDateKey) -> NSDate? {
        return object(forKey: key.name) as? NSDate
    }
}

protocol TypeWritable {}
extension UserDefaults: TypeWritable {
    public func save(value: Bool, key: UserDefaultBoolKey) {
        set(value, forKey: key.name)
        synchronize()
    }
    
    public func save(value: String, key: UserDefaultStringKey) {
        set(value, forKey: key.name)
        synchronize()
    }
    
    public func save(value: Int, key: UserDefaultIntKey) {
        set(value, forKey: key.name)
        synchronize()
    }
    
    public func save(value: Double, key: UserDefaultDoubleKey) {
        set(value, forKey: key.name)
        synchronize()
    }
    
    public func save(array: [String], key: UserDefaultArrayKey) {
        set(array, forKey: key.name)
        synchronize()
    }
    
    public func save(dictionary: [String: AnyObject], key: UserDefaultDictionaryKey) {
        set(dictionary, forKey: key.name)
        synchronize()
    }
    
    public func save(date: NSDate, key: UserDefaultDateKey) {
        set(date, forKey: key.name)
        synchronize()
    }
}

protocol TypeDeletable {}
extension UserDefaults: TypeDeletable {
    private func removeAndSyncObject(forKey key: String) {
        removeObject(forKey: key)
        synchronize()
    }
    
    public func remove(key: UserDefaultKey) {
        removeAndSyncObject(forKey: key.name)
    }
}
