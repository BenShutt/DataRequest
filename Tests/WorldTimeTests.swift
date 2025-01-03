//
//  WorldTimeTests.swift
//  DataRequestTests
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Testing
@testable import DataRequest

@Suite("Integration tests for the World Time API")
struct WorldTimeTests {
    private let timeZone = "Europe/London"

    @Test func test() async throws {
        let worldTime = try await GetWorldTime(timeZone: timeZone).request()
        #expect(worldTime.timezone == timeZone)
    }
}
