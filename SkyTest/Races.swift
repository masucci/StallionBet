//
//  Races.swift
//  SkyTest
//
//  Created by Lorenzo on 16/10/2020.
//

import Foundation

struct Races: Codable {
    let races: [RaceInfo]
}

struct RaceInfo: Codable {
    let race_summary: RaceSpecification
    let rides: [Ride]
}

struct RaceSpecification: Codable {
    let name: String
    let course_name: String
}

struct Ride: Codable {
    let cloth_number: Int
    let horse: HorseInfo
    let current_odds: String
}

struct HorseInfo: Codable {
    let name: String
    let sex: String
}
