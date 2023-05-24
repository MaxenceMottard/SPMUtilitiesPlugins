// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SPMUtilitiesPlugins",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .plugin(name: "SwiftLintPlugin", targets: ["SwiftLintPlugin"]),
        .plugin(name: "SwiftlintCommandPlugin", targets: ["SwiftlintCommandPlugin"]),
        .plugin(name: "SwiftFormatPlugin", targets: ["SwiftFormatPlugin"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "swiftformat",
            url: "https://github.com/nicklockwood/SwiftFormat/releases/download/0.51.1/swiftformat.artifactbundle.zip",
            checksum: "af70ed2d4667c2ac22a40a26df187443d0ffc962959f97f39f7fb8b2765b5ef3"
        ),
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.52.2/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "89651e1c87fb62faf076ef785a5b1af7f43570b2b74c6773526e0d5114e0578e"
        ),
        .plugin(
            name: "SwiftFormatPlugin",
            capability: .command(
                intent: .custom(verb: "swiftformat", description: "Formats Swift source files using SwiftFormat"),
                permissions: [
                    .writeToPackageDirectory(reason: "This command reformats source files"),
                ]
            ),
            dependencies: ["swiftformat"]
        ),
        .plugin(
            name: "SwiftLintPlugin",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),
        .plugin(
            name: "SwiftlintCommandPlugin",
            capability: .command(intent: .custom(verb: "swiftlint", description: "Lint files with SwiftFormat")),
            dependencies: ["SwiftLintBinary"]
        ),
    ]
)
