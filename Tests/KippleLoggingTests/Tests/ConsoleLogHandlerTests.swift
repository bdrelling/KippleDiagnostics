// Copyright © 2024 Brian Drelling. All rights reserved.

@testable import KippleLogging
import XCTest

final class ConsoleLogHandlerTests: XCTestCase, LogHandlerValidating {
    func testLogHandlerConformanceIsValid() {
        self.validateLogLevel(ConsoleLogHandler.init)
    }
}
