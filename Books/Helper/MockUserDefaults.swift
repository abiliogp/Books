//
//  MockUserDefaults.swift
//  Books
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import Foundation

class MockUserDefaults: UserDefaults {
    var data = [String: Any]()
    
    override func set(_ value: Any?, forKey defaultName: String) {
        data[defaultName] = value
    }
    
    override func array(forKey defaultName: String) -> [Any]? {
        return data[defaultName] as? [Any]
    }
}
