//
//  GetWorldTime.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire
import DataRequest

/// Get the world time for a time zone
struct GetWorldTime: DecodableRequest {

    /// Decode response as `WorldTime`
    typealias ResponseBody = WorldTime

    /// The time zone to fetch
    let timeZone: String

    /// The Alamofire session
    let session: Session = .worldTime

    /// Define a specific `JSONDecoder` with snake case and ISO8601 dates
    let decoder: DataDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom { decoder in
            let iso8601 = try decoder.singleValueContainer().decode(String.self)
            let format = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
            return try format.parse(iso8601)
        }
        return decoder
    }()

    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "worldtimeapi.org"
        urlComponents.path = "/api/timezone/\(timeZone)"
        return urlComponents
    }

    var headers: HTTPHeaders {
        .default.appending(.acceptJSON)
    }
}

// MARK: - Session + WorldTime

private extension Session {
    static let worldTime = Session(eventMonitors: [
        ResponseEventMonitor()
    ])
}
