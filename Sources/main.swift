import Foundation
import Kitura
import HeliumLogger

// HeliumLoggerを初期化
HeliumLogger.use()

let router = Router()
router.get("/") { request, response, next in
	response.send("Hello, World!")
	next()
}

// Herokuでポート番号が変えられるようにする
let port: Int = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8090") ?? 8090

Kitura.addHTTPServer(onPort: port, with: router)

Kitura.run()
