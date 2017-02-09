import Foundation

import Kitura
import HeliumLogger
import KituraStencil
import SwiftyBeaver

let log = SwiftyBeaver.self
log.addDestination(ConsoleDestination())

let session = URLSession(configuration: URLSessionConfiguration.default)

//let request = GetSearchRequest(keyword: "terminator").request
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//	guard let data = data else {
//		return
//	}
//
//	do {
//		let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//		let results = try SearchResultsModel.decode(json)
//		log.debug(results)
//	} catch {
//		print("parse error!")
//	}
//}
//task.resume()

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

router.get("/search") { request, response, next in
	let q = request.queryParameters["q"] ?? ""
	let req = GetSearchRequest(keyword: q).request
	let task = session.dataTask(with: req, completionHandler: { object, res, error in
		guard let object = object else {
			return
		}
		guard let json = try? JSONSerialization.jsonObject(with: object, options: .allowFragments) else {
			return
		}
		guard let results = try? SearchResultsModel(object: json).results else {
			return
		}

		let context: [String : Any] = [
			"keyword" : q,
			"results" : results
		]
		do {
			try response.render("search", context: context)
			next()
		} catch {
			try? response.send(status: .internalServerError).end()
			return
		}
	})
	task.resume()
}

router.get("/detail/:id") { request, response, next in
	guard
		let idString = request.parameters["id"],
		let id = Int(idString) else {
		try response.send(status: .badRequest).end()
		return
	}

	let req = GetMoviesWithIDRequest(id: id).request
	let task = session.dataTask(with: req, completionHandler: { object, res, error in
		guard let object = object else {
			return
		}
		guard let json = try? JSONSerialization.jsonObject(with: object, options: .allowFragments) else {
			return
		}
		guard let movieDetail = try? MovieDetailModel(object: json) else {
			return
		}

		let context: [String : Any] = [
			"movie" : movieDetail
		]
		do {
			try response.render("detail", context: context)
			next()
		} catch {
			try? response.send(status: .internalServerError).end()
			return
		}
	})
	task.resume()
}

let port: Int = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8090") ?? 8090
Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
