//
//  WorldTime.swift
//  DataRequestTests
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

/// Model from the World Time API
/// http://worldtimeapi.org
struct WorldTime: Decodable {

    var abbreviation: String
    var datetime: Date
    var dstOffset: Int
    var rawOffset: Int
    var timezone: String
}
