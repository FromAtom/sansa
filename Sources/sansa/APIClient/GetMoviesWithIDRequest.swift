//
//  GetMoviesWithIDRequest.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

struct GetMoviesWithIDRequest: GuideboxAPIRequestType {
	let id: Int
	let method: HTTPMethod = .get
	var path: String {
		return "/movies/\(id)"
	}
	let query: [String : String] = [:]
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
