//
//  DateFormatter.swift
//  Pokedex
//
//  Created by Breno Valadão on 17/11/21.
//

import Foundation

extension DateFormatter {
    static let mediumDateTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = .autoupdatingCurrent
        return dateFormatter
    }()
}
