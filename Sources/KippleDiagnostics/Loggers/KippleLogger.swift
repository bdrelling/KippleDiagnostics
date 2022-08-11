// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import Logging

/// A convenience wrapper for `SwiftLog`'s `Logger` struct, which emits log messages corresponding to a log level.
public struct KippleLogger: KippleLogging {
    // MARK: Properties

    public let logger: Logger

    // MARK: Initializers

    public init(logger: Logger) {
        self.logger = logger
    }
}

// MARK: - Convenience

public extension KippleLogging where Self == KippleLogger {
    /// Creates a `KippleLogger` configured for the active build configuration.
    /// The default self.logger is just a best attempt at providing convenient access to logging out-of-the-box.
    /// For all real-world use cases, it is recommended to create your own instance of `KippleLogger` for your application.
    static func `default`(_ label: String = Logger.defaultLabel) -> Self {
        #if DEBUG
            .debug(label)
        #else
            .release(label)
        #endif
    }

    /// Creates a `KippleLogger` configured with the `debug` minimum log level for `debug` configurations.
    static func debug(_ label: String = Logger.defaultLabel) -> Self {
        .init(logger: .debug(label))
    }

    /// Creates a `KippleLogger` configured with the `warning` minimum log level for `release` configurations.
    static func release(_ label: String = Logger.defaultLabel) -> Self {
        .init(logger: .release(label))
    }
}
