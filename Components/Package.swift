// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Components",
		defaultLocalization: "en",
		platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library( name: "Components", targets: ["Components"]),
				.library(name: "AssetKit", targets: ["AssetKit"]),
				.library(name: "ViewComponents", targets: ["ViewComponents"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Components",
            dependencies: ["AssetKit"]),
				.target(
					name: "AssetKit",
					plugins: ["SwiftGenPlugin"]
				),
				.target(
					name: "ViewComponents",
					dependencies: ["AssetKit"]
				),
        .testTarget(
            name: "ComponentsTests",
            dependencies: ["Components"]),
    ]
)

// MARK: Plugins
let pluginTargets: [Target] = [
	.plugin(
		name: "SwiftGenPlugin",
		capability: .buildTool(),
		dependencies: [
			"SwiftGenBinary"
		]
	),
	// The vended executable that generates source files.
	.binaryTarget(
		name: "SwiftGenBinary",
		path: "Binaries/SwiftGenBinary.artifactbundle"
	)
]

package.targets.append(contentsOf: pluginTargets)
