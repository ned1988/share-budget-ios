//
//  Dependency.swift
//  ShareBudget
//
//  Created by Denys Meloshyn on 03.06.17.
//  Copyright © 2017 Denys Meloshyn. All rights reserved.
//

import JustLog
import XCGLogger
import url_builder

enum Environment {
    case testing
    case production
    case developmentLocal
    case developmentRemote
}

class Dependency {
    static let instance = Dependency()

    private init() {
    }

    static let loggerRemoteIdentifier = "advancedLogger.remoteDestination"

    static var logger: XCGLogger!
    static var coreDataName: String!
    static var restAPIVersion: String!
    static var userCredentials: UserCredentialsProtocol!
    static var backendURLComponents: NSURLComponents!

    static var backendConnection: URLComponents {
        Dependency.instance.restApiComponents()
    }

    class func environment() -> Environment {
        if let testPath = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] {
            let url = URL(fileURLWithPath: testPath)

            if url.pathExtension == "xctestconfiguration" {
                return .testing
            }
        }

        #if DEVELOPMENT_LOCAL
        return Environment.developmentLocal
        #elseif DEVELOPMENT_REMOTE
        return Environment.developmentRemote
        #else
        return Environment.production
        #endif
    }

    class func configure() {
        self.configureUserCredentials()
        self.configureLogger()
        self.configureBackendConnection()
        self.configureDataBaseName()

        self.logger.info(self.environment)
    }

    static private let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()

    class private func configureLogger() {
        Logger.shared.logstashHost = "listener.logz.io"
        Logger.shared.logstashPort = 5052
        Logger.shared.logzioToken = "KwzGuzHVRmyojtidIOicPEZrQbZEzGCQ"
        Logger.shared.enableConsoleLogging = false
        Logger.shared.setup()

        // Create a logger object with no destinations
        self.logger = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)

        // Create a destination for the system console log (via NSLog)
        let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.systemDestination")

        // Optionally set some configuration options
        systemDestination.outputLevel = .debug
        systemDestination.showLogIdentifier = false
        systemDestination.showFunctionName = true
        systemDestination.showThreadName = false
        systemDestination.showLevel = true
        systemDestination.showFileName = true
        systemDestination.showLineNumber = true
        systemDestination.showDate = true

        // Add the destination to the logger
        self.logger.add(destination: systemDestination)

        // Create a file log destination
        let logPath: URL = self.cacheDirectory.appendingPathComponent("XCGLogger_Log.txt")
        let fileDestination = FileDestination(writeToFile: logPath, identifier: "advancedLogger.fileDestination")

        // Optionally set some configuration options
        fileDestination.outputLevel = .debug
        fileDestination.showLogIdentifier = false
        fileDestination.showFunctionName = true
        fileDestination.showThreadName = true
        fileDestination.showLevel = true
        fileDestination.showFileName = true
        fileDestination.showLineNumber = true
        fileDestination.showDate = true

        // Process this destination in the background
        fileDestination.logQueue = XCGLogger.logQueue

        // Add the destination to the logger
        self.logger.add(destination: fileDestination)

        if self.environment() == .production || self.environment() == .developmentRemote {
            // Remote destination
            let remoteLogsDestination = RemoteLogsDestination(identifier: self.loggerRemoteIdentifier)
            remoteLogsDestination.outputLevel = .debug
            remoteLogsDestination.showLogIdentifier = false
            remoteLogsDestination.showFunctionName = true
            remoteLogsDestination.showThreadName = false
            remoteLogsDestination.showLevel = true
            remoteLogsDestination.showFileName = true
            remoteLogsDestination.showLineNumber = true
            remoteLogsDestination.showDate = true

            self.logger.add(destination: remoteLogsDestination)
        }

        // Add basic app info, version info etc, to the start of the logs
        self.logger.logAppDetails()
    }

    class private func configureBackendConnection() {
        let components = NSURLComponents()
        Dependency.restAPIVersion = "v1"

        switch self.environment() {
        case .developmentLocal:
            components.scheme = "http"
            components.host = "127.0.0.1"
            components.port = 5000

        case .developmentRemote:
            components.scheme = "https"
            components.host = "sharebudget-development.herokuapp.com"

        case .production:
            components.scheme = "https"
            components.host = "sharebudget-development.herokuapp.com"

        default:
            break
        }

        self.backendURLComponents = components
    }

    func restApiUrlBuilder(environment: Environment = Dependency.environment()) -> URL.Builder {
        let builder: URL.Builder

        switch environment {
        case .developmentLocal:
            builder = URL.Builder.http.host("127.0.0.1").appendPath(Dependency.restAPIVersion).port(5000)

        case .developmentRemote:
            builder = URL.Builder
                         .https
                         .host("sharebudget-development.herokuapp.com")
                         .appendPath(Dependency.restAPIVersion)

        case .production:
            builder = URL.Builder
                         .https
                         .host("sharebudget-development.herokuapp.com")
                         .appendPath(Dependency.restAPIVersion)

        case .testing:
            builder = URL.Builder.scheme("")
        }

        return builder
    }

    func restApiComponents() -> URLComponents {
        var components = URLComponents()

        switch Dependency.environment() {
        case .developmentLocal:
            components.scheme = "http"
            components.host = "127.0.0.1"
            components.port = 5000

        case .developmentRemote:
            components.scheme = "https"
            components.host = "sharebudget-development.herokuapp.com"

        case .production:
            components.scheme = "https"
            components.host = "sharebudget-development.herokuapp.com"

        default:
            break
        }

        return components
    }

    class private func configureUserCredentials() {
        self.userCredentials = UserCredentials.instance
    }

    class private func configureDataBaseName() {
        if self.environment() == .testing {
            self.coreDataName = "ShareBudgetTest"
            return
        }

        self.coreDataName = "ShareBudget"
    }
}
