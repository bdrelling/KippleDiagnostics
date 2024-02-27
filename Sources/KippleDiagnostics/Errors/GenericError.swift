// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

/// A generic error, primarily used for quickly converting a `String` into an `Error`.
struct GenericError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? {
        self.message
    }
}
