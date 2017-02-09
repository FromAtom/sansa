import Foundation

import Kitura
import HeliumLogger
import KituraStencil
import APIKit
import Decodable
import SwiftyBeaver

let log = SwiftyBeaver.self
log.addDestination(ConsoleDestination())

let request = GetSearchRequest(keyword: "Terminator")
log.debug(request.baseURL)
Session.send(request) { result in
	print("aaa")
	switch result {
	case .success(let response):
		log.debug(response)
	case .failure(let error):
		log.error(error)
	}
}
log.debug("aaa")



struct RateLimitRequest: Request {
	typealias Response = RateLimit

	var baseURL: URL {
		return URL(string: "https://api.github.com")!
	}

	var method: HTTPMethod {
		return .get
	}

	var path: String {
		return "/rate_limit"
	}

	func response(from object: Any, urlResponse: HTTPURLResponse) throws -> RateLimit {
		return try RateLimit(object: object)
	}
}

struct RateLimit {
	let limit: Int
	let remaining: Int

	init(object: Any) throws {
		guard let dictionary = object as? [String: Any],
			let rateDictionary = dictionary["rate"] as? [String: Any],
			let limit = rateDictionary["limit"] as? Int,
			let remaining = rateDictionary["remaining"] as? Int else {
				throw ResponseError.unexpectedObject(object)
		}

		self.limit = limit
		self.remaining = remaining
	}
}

let hoge = RateLimitRequest()
Session.send(hoge) { result in
	log.debug("hhh")
	switch result {
	case .success(let response):
		log.debug(response)
	case .failure(let error):
		log.error(error)
	}
}
log.flush(secondTimeout: 0)

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
