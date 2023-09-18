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
struct GetWorldTime: JSONDataRequest {

    /// Decode response as `WorldTime`
    typealias ResponseBody = WorldTime

    /// The time zone to fetch, defaults to `"Europe/London"`
    var timeZone: String

    /// The Alamofire session
    var session: Session {
        .worldTime
    }

    /// Define a specific `JSONDecoder`
    var decoder: DataDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601Millis)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    /// `URLComponents` for World Time
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "worldtimeapi.org"
        urlComponents.path = "/api/timezone/\(timeZone)"
        urlComponents.queryItems = nil
        return urlComponents
    }
}
