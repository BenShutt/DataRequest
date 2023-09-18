//
//  ISO8601DateFormatter+Extensions.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

// MARK: - DateFormatter + ISO8601

extension DateFormatter {

    /// An ISO8601 `DateFormatter` with milliseconds.
    static var iso8601Millis: DateFormatter {
        iso8601Formatter(dateFormat: .iso8601Millis)
    }

    /// An ISO8601 `DateFormatter` without milliseconds.
    static var iso8601: DateFormatter {
        iso8601Formatter(dateFormat: .iso8601)
    }

    /// An ISO8601 `DateFormatter` with:
    /// - Calendar identifier `.iso8601`
    /// - Locale identidier `"en_US_POSIX"`
    /// - Given `timeZone`, defaults to `.current`
    /// - Given `dateFormat`
    ///
    /// - Parameters:
    ///   - timeZone: The time zone, defaults to `.current`
    ///   - dateFormat: The date format
    /// - Returns: `DateFormatter`
    private static func iso8601Formatter(
        timeZone: TimeZone? = .current,
        dateFormat: String
    ) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        return formatter
    }
}

// MARK: - String + ISO8601

private extension String {

    /// Date format for ISO8601 including milliseconds
    static let iso8601Millis: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

    /// Date format for ISO8601
    static let iso8601 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
}
