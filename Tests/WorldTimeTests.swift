//
//  WorldTimeTests.swift
//  DataRequestTests
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Testing
@testable import DataRequest

/// _Integration_ tests using the World Time API
@Suite struct WorldTimeTests {
    private let timeZone = "Europe/London"

    @Test func test() async throws {
        let worldTime = try await GetWorldTime(timeZone: timeZone).request()
        #expect(worldTime.timezone == timeZone)
    }
}
