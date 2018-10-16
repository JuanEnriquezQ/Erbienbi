//
//  FireLogic.swift
//  Erbienbi
//
//  Created by juan.enriquez on 15/10/18.
//  Copyright © 2018 juan.enriquez. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class FireLogic {
    static let shared = FireLogic()
    private var ref: DatabaseReference
    private var storageRef: StorageReference
    
    init(){
        ref = Database.database().reference()
        storageRef = Storage.storage().reference().child("images")
    }
}
extension FireLogic{
    //RETURN EVERY "SPACE" IN THE DATABASE
    func getPopularSpaces(completionHandler: @escaping([Space],String)-> Void){
        ref.child("Spaces").observeSingleEvent(of: .value) { (snapshot) in
            if let dictionaryResponse = snapshot.value as? [String: [String: Any]]{
                let spaces = dictionaryResponse.map {Space(id: $0.key, dictionary: $0.value)}
                completionHandler(spaces,"")
            } else{
                completionHandler([],"Error")
            }
        }
    }
    
    //RETURNS ALL EVENTS
    func getEventsAllEvents(completionHandler: @escaping([Event],String)->Void){
        ref.child("Events").observeSingleEvent(of: .value) { (snapshot) in
            if let dictionaryResponse = snapshot.value as? [String: [String:Any]]{
                let events = dictionaryResponse.map {Event(id: $0.key, dictionary: $0.value)}
                completionHandler(events,"")
            } else{
                completionHandler([],"Error")
            }
        }
    }
    
    //RETURNS ALL EVENTS IN A CERTAIN LOCATION (CITY)
    func getEventsAtCurrentLocation(city: String, completionHandler: @escaping([Event], String) -> Void) {
        ref.child("Events").observeSingleEvent(of: .value) { (snapshot) in
            if let dictionaryResponse = snapshot.value as? [String: [String: Any]]{
                let events = dictionaryResponse.map {Event(id: $0.key, dictionary: $0.value)}
                let localEvents = events.filter({ $0.locationCity == city})
                completionHandler(localEvents, "")
            } else{
                completionHandler([],"Error")
            }
        }
    }
    
    //ADDS A RECORD OF SPACE TO THE DATABASE
    func addSpaceToDatabase(name: String, desc: String, price: Double, city: String){
        let current = ref.child("Spaces").childByAutoId()
        current.child("name").setValue(name)
        current.child("description").setValue(desc)
        current.child("price").setValue(price)
        current.child("locationCity").setValue(city)
    }
}

