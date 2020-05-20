//
//  Prayer.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/3/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import Foundation

// MARK: - Prayer
struct Prayer: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let timings: Timings
}

// MARK: - Timings
struct Timings: Codable {
    let Fajr,  Dhuhr, Asr: String?
    let Maghrib, Isha: String?
}
