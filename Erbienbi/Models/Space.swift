//
//  Space.swift
//  Erbienbi
//
//  Created by juan.enriquez on 15/10/18.
//  Copyright © 2018 juan.enriquez. All rights reserved.
//

import Foundation

struct Space {
    var id: String?
    var name : String?
    var price : Double?
    var locationCity: String?
    var description: String?
    var imageURL: String?
    
    init(id: String, dictionary: [String: Any]) {
        self.id = id
        self.name = dictionary["name"] as? String ?? ""
        self.price = dictionary["price"] as? Double ?? 10.0
        self.locationCity = dictionary["locationCity"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.imageURL = dictionary["imageURL"] as? String ?? ""
    }

}
