//
//  User.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var company: Company
    var address: Address
}

struct Company: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
}

struct Address: Codable {
    var street: String
    var city: String
    var zipcode: String
    var suite: String

}

struct Geo: Codable {
    var lat, lng: Double
}
