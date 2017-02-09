import Foundation

import Kitura
import HeliumLogger
import KituraStencil

// HeliumLoggerを初期化
HeliumLogger.use()

let router = Router()
router.setDefault(templateEngine: StencilTemplateEngine())
router.all("/css", middleware: StaticFileServer(path: "./Public/Stylesheets", options: StaticFileServer.Options(), customResponseHeadersSetter: nil))

router.get("/") { request, response, next in
	defer {
		next()
	}

	let context: [String : Any] = [
		"comment" : "テストです。"
	]

	do {
		try response.render("index", context: context)
	} catch {
		try response.send(status: .internalServerError).end()
	}
}

let port: Int = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8090") ?? 8090
Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
