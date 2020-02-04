//
//  Data.swift
//  InfiniteScroll
//
//  Created by Amay Singhal on 10/6/15.
//  Copyright © 2015 ple. All rights reserved.
//

import Foundation

struct CaCities {
    static func getCities(from index: Int, andCount count: Int, withCompletion completion: @escaping ([String]) -> ())  {
        DispatchQueue.global(qos: .background).async {
            let start = index.limit(0...AllCities.endIndex)
            let end = (index + count).limit(0...AllCities.endIndex)

            let nextCities = Array(CaCities.AllCities[start..<end])

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(nextCities)
            }
        }
    }

    private static let AllCities = (0...441).map {_ in source.randomElement()! }
    private static let source = [
        "Anchorage, AK",
        "Atlanta, GA",
        "Birmingham, AL",
        "Columbus-Tupelo-West Point, MS",
        "Columbus, GA",
        "Dothan, AL",
        "Fairbanks, AK",
        "Ft. Smith-Fayetteville-Springdale-Rogers, AR",
        "Huntsville-Decatur (Florence), AL",
        "Jonesboro, AR",
        "Juneau, AK",
        "Little Rock-Pine Bluff, AR",
        "Memphis, TN",
        "Meridian, MS",
        "Mobile, AL-Pensacola (Ft. Walton Beach), FL",
        "Monroe, LA-El Dorado, AR",
        "Montgomery (Selma), AL",
        "Shreveport, LA",
        "Springfield, MO"
    ]
}

extension Comparable {
    func limit(_ range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
