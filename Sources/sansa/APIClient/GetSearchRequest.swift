//
//  GetSearchRequest.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation
import APIKit
import Decodable

struct GetSearchRequest: GuideboxAPIRequestType {
	typealias Response = [SearchResultModel]

	let keyword: String
	let method: HTTPMethod = .get
	let path: String = "/search"
//	var queryParameters: [String : Any] {
//		return [
//			"type" : "movie",
//			"field" : "title",
//			"query" : keyword
//		]
//	}
	var parameters: Any? {
		return [
			"type" : "movie",
			"field" : "title",
			"query" : keyword
		]
	}

	func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [SearchResultModel] {
		do {
			let response = try SearchResultsModel.decode(object)
			guard let results = response.results else {
				let error: Any = response.error ?? object
				throw ResponseError.unexpectedObject(error)
			}

			return results
		} catch {
			throw ResponseError.unexpectedObject(object)
		}
	}
}
