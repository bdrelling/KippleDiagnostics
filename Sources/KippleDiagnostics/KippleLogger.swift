// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import Logging

extension LogHandler where Self == ConsoleLogHandler {
    static func console(label: String) -> Self {
        .init(label: label)
    }
}

/// A wrapper for `SwiftLog`'s `Logger` struct, which emits log messages corresponding to a log level.
public final class KippleLogger {
    // MARK: Properties

    /// The base self.logger to send all log events through.
    ///
    /// This is initialized with a default self.logger labeled with "Uninitialized" with no handlers attached, to avoid optionality.
    private var logger = Logger(label: "Uninitialized")

    /// The minimum log level for the self.logger.
    public var logLevel: Logger.Level {
        get {
            self.logger.logLevel
        }
        set {
            self.logger.logLevel = newValue
        }
    }

    // MARK: Initializers

    /// Initializes a `KippleLogger` with a provided `LogHandler` factory method.
    public init(label: String, logLevel: Logger.Level, logHandler: @escaping (String) -> LogHandler) {
        self.logger = .init(label: label, factory: logHandler)
        self.logger.logLevel = logLevel
    }

    /// Initializes a `KippleLogger` with a provided `LogHandler`.
    public convenience init(label: String, logLevel: Logger.Level, logHandler: LogHandler) {
        self.init(label: label, logLevel: logLevel, logHandler: { _ in logHandler })
    }

    /// Initializes a `KippleLogger` with the default `ConsoleLogHandler`.
    public convenience init(label: String, logLevel: Logger.Level) {
        self.init(label: label, logLevel: logLevel, logHandler: .console(label: label))
    }

    // MARK: Methods - Message Logging

    /// Logs a message with an associated log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - level: The log level to log `message` at. For the available log levels, see `Logger.Level`.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    public func log(
        _ message: String,
        level: Logger.Level,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.logger.log(level: level, "\(message)", metadata: metadata, file: file, function: function, line: line)
    }

    // MARK: Methods - Error Reporting

    /// Reports an error with an associated log level.
    /// - Parameters:
    ///    - error: The error to be logged. `error` is combined with `message` for easy error reporting.
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - level: The log level to log `message` at. For the available log levels, see `Logger.Level`.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    public func report(
        _ error: Error,
        message: String? = nil,
        level: Logger.Level = .error,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        let formattedMessage: String = {
            if let message = message {
                return "\(message) \(error.localizedDescription)"
            } else {
                return error.localizedDescription
            }
        }()

        self.log(formattedMessage, level: level, metadata: metadata, file: file, function: function, line: line)
    }
}

// MARK: - Supporting Types

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

// MARK: - Convenience

public extension KippleLogger {
    static let defaultLabel = "Kipple"

    /// Creates a `KippleLogger` configured for the active build configuration.
    /// The default self.logger is just a best attempt at providing convenient access to logging out-of-the-box.
    /// For all real-world use cases, it is recommended to create your own instance of `KippleLogger` for your application.
    static func `default`(_ label: String = KippleLogger.defaultLabel) -> Self {
        #if DEBUG
            .debug(label)
        #else
            .release(label)
        #endif
    }

    /// Creates a `KippleLogger` configured with the `debug` minimum log level for `debug` configurations.
    static func debug(_ label: String = KippleLogger.defaultLabel) -> Self {
        .init(label: label, logLevel: .debug)
    }

    /// Creates a `KippleLogger` configured with the `warning` minimum log level for `release` configurations.
    static func release(_ label: String = KippleLogger.defaultLabel) -> Self {
        .init(label: label, logLevel: .warning)
    }
}

// MARK: - Extensions

public extension KippleLogger {
    /// Logs a message with the `debug` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func debug(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .debug, metadata: metadata, file: file, function: function, line: line)
    }

    /// Logs a message with the `info` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func info(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .info, metadata: metadata, file: file, function: function, line: line)
    }

    /// Logs a message with the `warning` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func warning(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .warning, metadata: metadata, file: file, function: function, line: line)
    }

    /// Logs a message with the `report` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func report(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.report(GenericError(message), metadata: metadata, file: file, function: function, line: line)
    }
}
