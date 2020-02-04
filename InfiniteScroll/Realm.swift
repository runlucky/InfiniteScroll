//
//  Realm.swift
//  InfiniteScroll
//
//  Created by H5266 on 2020/02/04.
//  Copyright © 2020 ple. All rights reserved.
//

import Foundation

class Realm {
    private var cities: [City] = {
        (10...20).compactMap {
            if $0 % 2 == 0 { return nil }
            return City(timestamp: Date(timeIntervalSince1970: Double(1580719378 - $0)), from: "Local")
        }
    }()

    func add(cities newCities: [City]) {
        let oldCities = cities.filter { city in
            !newCities.contains(city)
        }

        self.cities = oldCities + newCities
    }

    func getCities() -> [City] {
        cities
    }
}
