import Foundation

import Kitura
import HeliumLogger
import KituraMustache

// HeliumLoggerを初期化
HeliumLogger.use()

let router = Router()
router.add(templateEngine: MustacheTemplateEngine())

router.get("/") { request, response, next in
	defer {
		next()
	}

	let context: [String : Any] = [
		"comment": "こんちわ"
	]

	try response.render("index.mustache", context: context).end()
}

// Herokuでポート番号が変えられるようにする
let port: Int = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8090") ?? 8090

Kitura.addHTTPServer(onPort: port, with: router)

Kitura.run()
