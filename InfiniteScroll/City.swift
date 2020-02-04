//
//  City.swift
//  InfiniteScroll
//
//  Created by H5266 on 2020/02/04.
//  Copyright © 2020 ple. All rights reserved.
//

import Foundation

struct City {
    let timestamp: Date
    let from: String


    var description: String {
        "\(timestamp.toString(.date)): \(from)"
    }
}

extension City: Comparable {
    static func < (lhs: City, rhs: City) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.timestamp == rhs.timestamp
    }
}


extension Date {
    func toString(_ template: DateFormatter.Template) -> String {
        formatter.setTemplate(template)
        return formatter.string(from: self)
    }
}

fileprivate let formatter: DateFormatter = {
    let f = DateFormatter()
    f.timeStyle = .medium
    f.dateStyle = .none
    f.locale = Locale(identifier: "ja_JP")
    return f
}()

extension DateFormatter {
    // テンプレートの定義(例)
    enum Template: String {
        case date = "yyyyMMdd HHmmss"     // 2017/1/1
        case time = "ss"     // 12:39:22
    }

    func setTemplate(_ template: Template) {
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}
