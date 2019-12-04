//
//  FileManagerExtensions.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 8/4/18.
//  Copyright © 2018 Anteneh Sahledengel. All rights reserved.
//

import UIKit

public extension FileManager {

    /// Documents directory
    static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    /// Save data to file with the specified name
    static func saveToFile(data: Data, fileName: String, completion: ((Bool)-> Void)? = nil) {
        DispatchQueue.global(qos: .utility).async {
            let directory = documentsDirectory().appendingPathComponent("\(fileName)")
            do {
                try data.write(to: directory, options: .atomic)
                DispatchQueue.main.async {
                    completion?(true)
                }
            } catch let error {
                print("Error writing data to file: \(error)")
                DispatchQueue.main.async {
                    completion?(false)
                }
            }
        }
    }
    
    /// This is executed in a background queue and result is returned in the completion closure
    static func dataFromFile(fileName: String, completion: @escaping (Data?)-> Void) {
        DispatchQueue.global(qos: .utility).async {
            let data = dataFromFile(fileName: fileName)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    /// This is executed serially in whatever queue it is called on.
    static func dataFromFile(fileName: String) -> Data? {
        let directory = documentsDirectory().appendingPathComponent("\(fileName)")
        do {
            let data = try Data(contentsOf: directory)
            return data
        } catch let error {
            print("Error writing data to file: \(error)")
            return nil
        }
    }
    
    // MARK: Helpers
    
    /// Find an existing file's URL or throw an error if it doesn't exist
    static func getExistingFileURLInDocumentsDirectory(for path: String?) -> URL? {
        guard let url = createURLInDocumentsDirectory(for: path),
            FileManager.default.fileExists(atPath: url.path) else {
                return nil
        }
        
        return url
    }
    
    /// Create and returns a URL constructed from specified directory/path
    static func createURLInDocumentsDirectory(for path: String?) -> URL? {
        let filePrefix = "file://"
        
        guard let path = path,
            let validPath = FileManager.getValidFilePath(from: path) else {
                return nil
        }
        
        let searchPathDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        if var url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            url = url.appendingPathComponent(validPath, isDirectory: false)
            if url.absoluteString.lowercased().prefix(filePrefix.count) != filePrefix {
                let fixedUrlString = filePrefix + url.absoluteString
                url = URL(string: fixedUrlString)!
            }
            return url
        } else {
            return nil
        }
    }
    
    /// Convert a user generated name to a valid file name
    static func getValidFilePath(from originalString: String) -> String? {
        var invalidCharacters = CharacterSet(charactersIn: ":")
        invalidCharacters.formUnion(.newlines)
        invalidCharacters.formUnion(.illegalCharacters)
        invalidCharacters.formUnion(.controlCharacters)
        let pathWithoutIllegalCharacters = originalString
            .components(separatedBy: invalidCharacters)
            .joined(separator: "")
        let validFileName = removeSlashesAtBeginning(of: pathWithoutIllegalCharacters)
        guard validFileName.count > 0  && validFileName != "." else {
            return nil
        }
        return validFileName
    }
    
    /// Remove all "/" at the beginning of a String
    static func removeSlashesAtBeginning(of string: String) -> String {
        var string = string
        if string.prefix(1) == "/" {
            string.remove(at: string.startIndex)
        }
        if string.prefix(1) == "/" {
            string = removeSlashesAtBeginning(of: string)
        }
        return string
    }
    
    /// Check if file at a URL is a folder
    static func isFolder(_ url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) {
            if isDirectory.boolValue {
                return true
            }
        }
        return false
    }
}
