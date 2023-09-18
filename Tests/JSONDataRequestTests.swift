//
//  JSONDataRequestTests.swift
//  DataRequestTests
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import XCTest
@testable import DataRequest

final class JSONDataRequestTests: XCTestCase {

    private let timeZone = "Europe/London"

    func test() async throws {
        let worldTime = try await GetWorldTime(timeZone: timeZone).request()
        XCTAssertEqual(worldTime.timezone, timeZone)
    }
}
