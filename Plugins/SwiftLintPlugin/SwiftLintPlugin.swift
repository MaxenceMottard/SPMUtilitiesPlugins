//
//  SwiftLintPlugin.swift
//
//
//  Created by Maxence Mottard on 17/11/2022.
//

import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(
        context: PackagePlugin.PluginContext,
        target: PackagePlugin.Target
    ) async throws -> [PackagePlugin.Command] {
        print("BuildToolPlugin")
        print(context.pluginWorkDirectory)
        return [
            .buildCommand(
                displayName: "SwiftLint",
                executable: try context.tool(named: "swiftlint").path,
                arguments: [
                    "lint",
                    "--cache-path", "\(context.pluginWorkDirectory)",
                ]
            ),
        ]
    }
}

#if canImport(XcodeProjectPlugin)
    import XcodeProjectPlugin

    extension SwiftLintPlugin: XcodeBuildToolPlugin {
        func createBuildCommands(
            context: XcodePluginContext,
            target: XcodeTarget
        ) throws -> [Command] {
//            let filePaths = context.xcodeProject.targets
//                .map { $0.inputFiles }
//                .flatMap { $0 }
//                .map { $0.path.description }
//                .joined(separator: " ")

            [
                .buildCommand(
                    displayName: "SwiftLint",
                    executable: try context.tool(named: "swiftlint").path,
                    arguments: [
                        "\(context.xcodeProject.directory)/",
                        "--no-cache",
                    ]
                ),
            ]
        }
    }
#endif
