//
//  User.swift
//  Mothra
//
//  Created by kuroky on 2020/3/30.
//  Copyright © 2020 Emucoo. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    let city: String
    let name: String
}

class User2: NSObject, Codable {
    let city: String
    let name: String
    
    required init(city: String, name: String) {
        self.city = city
        self.name = name
        super.init()
    }
}

class User3: NSObject, NSCoding {
    let city: String
    let name: String
    
    required init(city: String, name: String) {
        self.city = city
        self.name = name
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(city, forKey: "city")
        coder.encode(name, forKey: "name")
    }
}
