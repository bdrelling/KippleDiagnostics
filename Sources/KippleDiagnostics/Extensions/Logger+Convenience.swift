// Copyright © 2022 Brian Drelling. All rights reserved.

import Logging

public extension Logger {
    static let defaultLabel = "Kipple"

    /// Creates a `Logger` configured for the active build configuration.
    /// The default self.logger is just a best attempt at providing convenient access to logging out-of-the-box.
    /// For all real-world use cases, it is recommended to create your own instance of `KippleLogger` for your application.
    static func `default`(_ label: String = Self.defaultLabel) -> Self {
        #if DEBUG
            .debug(label)
        #else
            .release(label)
        #endif
    }

    /// Creates a `Logger` configured with the `debug` minimum log level for `debug` configurations.
    static func debug(_ label: String = Self.defaultLabel) -> Self {
        .console(label: label, logLevel: .debug)
    }

    /// Creates a `Logger` configured with the `warning` minimum log level for `release` configurations.
    static func release(_ label: String = Self.defaultLabel) -> Self {
        .console(label: label, logLevel: .warning)
    }

    /// Creates a `Logger` configured to log to the console.
    static func console(label: String, logLevel: Logger.Level) -> Self {
        .init(label: label, logLevel: logLevel, logHandler: ConsoleLogHandler(label: label))
    }
}
