// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import KippleDiagnostics
import XCTest

final class ConsoleLogHandlerTests: XCTestCase, LogHandlerValidating {
    func testLogHandlerConformanceIsValid() {
        self.validateLogHandler(ConsoleLogHandler.init)
    }
}
