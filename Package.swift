import PackageDescription

let package = Package(
    name: "sansa",
    targets: [
		Target(
			name: "sansa",
			dependencies: []
		)
	],
    dependencies: [
		.Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 6),
		.Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 6),
		.Package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", majorVersion: 1, minor: 6),
		.Package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", majorVersion: 1)
	]
)
