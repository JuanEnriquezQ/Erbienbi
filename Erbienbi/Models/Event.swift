//
//  Event.swift
//  Erbienbi
//
//  Created by juan.enriquez on 16/10/18.
//  Copyright © 2018 juan.enriquez. All rights reserved.
//

import Foundation

struct Event {
    var id: String
    var date: String
    var locationCity: String
    var locationCountry: String
    var locationState: String
    var name: String
    
    init(id: String, dictionary: [String: Any]) {
        self.id = id
        self.date = dictionary["date"] as? String ?? ""
        self.locationCity = dictionary["locationCity"] as? String ?? ""
        self.locationCountry = dictionary["locationCountry"] as? String ?? ""
        self.locationState = dictionary["locationState"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
    }
}
