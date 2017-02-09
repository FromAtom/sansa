//
//  HuluSearcher.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

class HuluSearcher {
	static let sharedSearcher: HuluSearcher = HuluSearcher()

	let endpoint: String = "http://m.hulu.com/search"
	var baseURL: URLComponents {
		return URLComponents(string: endpoint)!
	}

	private init() { }

	func search(query: String) {
		let url = generateUrlForSearch(query: query)
	}

	/*
	http://m.hulu.com/search?dp_identifier=hulu&query=betty&items_per_page=20&page=1&region=jp&locale=ja&language=ja
	*/

	private func generateUrlForSearch(query: String) -> URLComponents {
		var url = baseURL
		url.queryItems = [
			URLQueryItem(name: "dp_identifier", value: "hulu"),
			URLQueryItem(name: "query", value: query),
			URLQueryItem(name: "items_per_page", value: "20"),
			URLQueryItem(name: "page", value: "1"),
			URLQueryItem(name: "region", value: "jp"),
			URLQueryItem(name: "locale", value: "jp"),
			URLQueryItem(name: "language", value: "jp")
		]

		print(url.string)
		return url
	}

}

