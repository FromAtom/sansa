//
//  GetSearchRequest.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

struct GetSearchRequest: GuideboxAPIRequestType {
	let keyword: String
	let method: HTTPMethod = .get
	let path: String = "/search"
	var query: [String : String] {
		return [
			"type" : "movie",
			"field" : "title",
			"query" : keyword
		]
	}
	var request: URLRequest {
		guard var components = URLComponents(string: endpoint) else {
			fatalError()
		}
		components.path += path

		var queryItems: [URLQueryItem] = []
		for (key, value) in query {
			let item = URLQueryItem(name: key, value: value)
			queryItems.append(item)
		}
		components.queryItems = queryItems

		guard let url = components.url else {
			fatalError()
		}

		var mutableRequest = URLRequest(url: url)
		for (key, value) in headers {
			mutableRequest.addValue(value, forHTTPHeaderField: key)
		}

		return mutableRequest
	}

}
