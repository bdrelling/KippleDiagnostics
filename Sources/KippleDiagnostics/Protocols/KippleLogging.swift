// Copyright © 2022 Brian Drelling. All rights reserved.

import Logging

public protocol KippleLogging {
    /// The base self.logger to send all log events through.
    var logger: Logger { get }

    init(logger: Logger)
}

// MARK: - Extensions

public extension KippleLogging {
    // MARK: Properties

    /// The minimum log level for the self.logger.
    var logLevel: Logger.Level {
        self.logger.logLevel
    }

    // MARK: Initializers

    init(label: String, logLevel: Logger.Level, factory: @escaping (String) -> LogHandler) {
        self.init(logger: .init(label: label, logLevel: logLevel, factory: factory))
    }

    init(label: String, logLevel: Logger.Level, logHandler: LogHandler? = nil) {
        let logHandler = logHandler ?? .console(label: label)
        self.init(logger: .init(label: label, logLevel: logLevel, logHandler: logHandler))
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
    func log(
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
    func report(
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
