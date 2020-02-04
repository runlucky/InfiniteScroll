//
//  Data.swift
//  InfiniteScroll
//
//  Created by Amay Singhal on 10/6/15.
//  Copyright © 2015 ple. All rights reserved.
//

import Foundation

struct CaCities {
    static func getServerCities(_ range: ClosedRange<Date>, withCompletion completion: @escaping ([City]) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            let cities = CaCities.serverCities.filter { city in
                range.contains(city.timestamp)
            }
            print("応答... \(cities.min()?.timestamp.toString(.time) ?? "nil")...\(cities.max()?.timestamp.toString(.time) ?? "nil")")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(cities)
            }
        }
    }

    private static let serverCities: [City] = {
        (0...30).map { City(timestamp: Date(timeIntervalSince1970: Double(1580719378 - $0)), from: "Server") }
    }()


}

extension Collection where Element: Comparable {
    public func sortedDescending() -> Array<Element> {
        return sorted { $0 > $1 }
    }
}


extension Comparable {
    func limit(_ range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
