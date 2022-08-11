// Copyright © 2022 Brian Drelling. All rights reserved.

import Sentry

/// An abstraction layer for Sentry.
///
/// For more information, see the [Sentry Apple SDK Documentation](https://docs.sentry.io/platforms/apple/).
final class SentryWrapper {
    // MARK: Initializers

    init() {}

    // MARK: Methods

    func initialize(environment: String, releaseName: String) {
        // https://docs.sentry.io/platforms/apple/guides/ios/configuration/options/
        SentrySDK.start { options in
            // Sentry API key.
            options.dsn = "https://6048fd5aea3842a9baf2daa37a10eca7@o348474.ingest.sentry.io/6117356"

            // Environment for tagging issues and traces properly.
            options.environment = environment

            // If enabled, SDK will attempt to print out useful debugging information.
            options.debug = false

            // Sets the verbosity of debug logging.
            options.diagnosticLevel = .debug

            // The total amount of breadcrumbs that should be captured.
            options.maxBreadcrumbs = 100

            // The release name is used for tagging issues and monitoring application performance.
            // This value should always 1:1 match with our version.
            // https://docs.sentry.io/product/releases/
            options.releaseName = releaseName

            // 1.0 == 100% of error events sent.
            options.sampleRate = 1.0

            // If enabled, certain personally identifiable information (PII) is added.
            // https://docs.sentry.io/platforms/apple/guides/ios/data-management/sensitive-data/
            options.sendDefaultPii = false

            // Percentage of performance tracking events sent. For example, 0.1 means 10% of events are sent.
            // TODO: Use AppConfigService's sentryTracesSampleRate in IOS-1410
            options.tracesSampleRate = 0.3
        }
    }

    func setUser(id: String) {
        SentrySDK.setUser(.init(userId: id))
    }

    func clearUser() {
        SentrySDK.setUser(nil)
    }

    func simulateCrash() {
        SentrySDK.crash()
    }

    func simulatePerformanceTransaction() {
        // Transaction can be started by providing the name and the operation
        let transaction = SentrySDK.startTransaction(
            name: "simulated-transaction",
            operation: "simulated-transaction-operation"
        )

        // Transactions can have child spans, and those spans can have child spans as well.
        let span = transaction.startChild(operation: "child-operation")

        // Only finished spans will be sent with the transaction.
        span.finish()

        // Finishing the transaction will send it to Sentry.
        transaction.finish()
    }
}
