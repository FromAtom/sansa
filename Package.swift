import PackageDescription

let package = Package(
    name: "sansa",
    dependencies: [
		.Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 4),
		.Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 4)
	]
)
