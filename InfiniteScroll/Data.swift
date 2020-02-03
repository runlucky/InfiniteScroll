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

        // get the data from data source in background thread
        // do not perform any expensive processing function on main queue as it will make the UI unresponsive
        DispatchQueue.global(qos: .background).async {
            var rangeStartIndex = index

            // handle start index out of bounds
            if rangeStartIndex < 0 {
                rangeStartIndex = 0
            } else if rangeStartIndex > CaCities.AllCities.endIndex {
                rangeStartIndex = CaCities.AllCities.endIndex
            }

            // handle end index out of bounds
            var rangeEndIndex = index + count
            if rangeEndIndex > CaCities.AllCities.endIndex {
                rangeEndIndex = CaCities.AllCities.endIndex
            }

            let nextCities = Array(CaCities.AllCities[rangeStartIndex..<rangeEndIndex])

            DispatchQueue.main.async {
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
