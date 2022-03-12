//
//  Model.swift
//  manualyParsingJSON
//
//  Created by User on 11.03.2022.
//

struct User: Codable {
    
    let gender: String?
    let name: PropertyName
    let location: Location
    
    init(value: [String:Any]) {
        gender = value["gender"] as? String
        
        let nameDict = value["name"] as? [String:String]
        name = PropertyName(value: nameDict ?? [:])
        
        let locationDict = value["location"] as? [String:Any]
        location = Location(value: locationDict ?? [:])
    }
    
   static func getUser(value: Any) -> [User] {
        guard let value = value as? [String:Any] else { return []}
        guard let results = value["results"] as? [[String:Any]] else { return []}
        return results.compactMap{User(value: $0)}
    }
}

struct PropertyName: Codable {
    let title: String?
    let first: String?
    let last: String?
    
    init(value: [String:String]){
        title = value["title"]
        first = value["first"]
        last = value["last"]
    }
}

struct Location: Codable {
    let city: String?
    let state: String?
    let street: Street
    
    init(value:[String:Any]){
        city = value["city"] as? String
        state = value["state"] as? String
        
        let streetDict = value["street"] as? [String:Any]
        street = Street(value: streetDict ?? [:])
        
        
    }
}

struct Street: Codable {
    let number: Int?
    let name: String?
    
    init(value:[String:Any]) {
        number = value["number"] as? Int
        name = value["name"] as? String
    }
}
