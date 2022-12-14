//
//  SwiftFormatPlugin.swift
//
//
//  Created by Maxence Mottard on 17/11/2022.
//

import Foundation
import PackagePlugin

@main
struct SwiftFormatPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let tool = try context.tool(named: "swiftformat")
        let toolURL = URL(fileURLWithPath: tool.path.string)

        var args = [context.pluginWorkDirectory.string] + arguments

        while let targetIndex = args.firstIndex(of: "--target") {
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

#if canImport(XcodeProjectPlugin)
    import XcodeProjectPlugin

    extension SwiftFormatPlugin: XcodeCommandPlugin {
        func performCommand(context: XcodePluginContext, arguments: [String]) throws {
            let tool = try context.tool(named: "swiftformat")
            let toolURL = URL(fileURLWithPath: tool.path.string)

            var args = [context.xcodeProject.directory.string] + arguments

            while let targetIndex = args.firstIndex(of: "--target") {
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
