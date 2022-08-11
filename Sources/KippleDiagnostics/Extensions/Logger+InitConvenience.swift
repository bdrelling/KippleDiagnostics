// Copyright © 2022 Brian Drelling. All rights reserved.

import Logging

public extension Logger {
    init(label: String, logLevel: Logger.Level) {
        self.init(label: label)
        self.logLevel = logLevel
    }

    init(label: String, logLevel: Logger.Level, factory: @escaping (String) -> LogHandler) {
        self.init(label: label, factory: factory)
        self.logLevel = logLevel
    }

    init(label: String, logLevel: Logger.Level, logHandler: LogHandler) {
        self.init(label: label, logLevel: logLevel, factory: { _ in logHandler })
    }
}
