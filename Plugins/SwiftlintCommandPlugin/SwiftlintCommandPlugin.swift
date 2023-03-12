//
//  SwiftlintCommandPlugin.swift
//  
//
//  Created by Maxence Mottard on 03/02/2023.
//
import Foundation
import PackagePlugin

@main
struct SwiftlintCommandPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let tool = try context.tool(named: "swiftlint")
        let toolURL = URL(fileURLWithPath: tool.path.string)

        var args = ["lint"] + arguments

        if let targetIndex = args.firstIndex(of: "--target") {
            args.remove(at: targetIndex)
            args.remove(at: targetIndex)
        }

        args.append("--no-cache")

        let process = Process()
        process.executableURL = toolURL
        process.arguments = args

        try process.run()
        process.waitUntilExit()
    }
}

#if canImport(XcodeProjectPlugin)
    import XcodeProjectPlugin

    extension SwiftlintCommandPlugin: XcodeCommandPlugin {
        func performCommand(context: XcodePluginContext, arguments: [String]) throws {
            let tool = try context.tool(named: "swiftlint")
            let toolURL = URL(fileURLWithPath: tool.path.string)

            var args = ["lint"] + arguments

            if let targetIndex = args.firstIndex(of: "--target") {
                args.remove(at: targetIndex)
                args.remove(at: targetIndex)
            }

            let process = Process()
            process.executableURL = toolURL
            process.arguments = args

            try process.run()
            process.waitUntilExit()
        }
    }
#endif
