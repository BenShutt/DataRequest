//
//  Atomic.swift
//  DataRequest
//
//  Created by Ben Shutt on 03/01/2025.
//  Copyright © 2025 Ben Shutt. All rights reserved.
//

import Foundation

/// Example of making a thread safe class using GCD
@propertyWrapper
final class Atomic<Stored: Sendable>: @unchecked Sendable {
    /// Concurrent dispatch queue
    private let queue = DispatchQueue(
        label: "\(Atomic.self)",
        attributes: .concurrent
    )

    /// A property that is thread safe and accessed only on the queue
    private var storedValue: Stored

    /// Get and set the stored value in a thread safe manner
    var wrappedValue: Stored {
        get {
            // Add operation to the queue.
            // Wait for the operation to finish.
            queue.sync {
                storedValue
            }
        }
        set {
            // Add operation to the queue.
            // Stop anything else running on the queue while this operation runs.
            // Do not wait for the operation to finish.
            queue.async(flags: .barrier) { [weak self] in
                self?.storedValue = newValue
            }
        }
    }

    /// Memberwise initializer
    /// - Parameter wrappedValue: The value to store
    init(wrappedValue: Stored) {
        storedValue = wrappedValue
    }
}
