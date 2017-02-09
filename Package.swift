import PackageDescription

let package = Package(
    name: "sansa",
    dependencies: [
		.Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 6),
		.Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 6),
		.Package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", majorVersion: 1, minor: 6),
		.Package(url: "https://github.com/ishkawa/APIKit.git", majorVersion: 3, minor: 1),
		.Package(url: "https://github.com/Anviking/Decodable.git", majorVersion: 0, minor: 5)
	]
)
