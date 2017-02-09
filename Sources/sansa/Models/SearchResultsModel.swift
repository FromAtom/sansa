//
//  SearchResultsModel.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

struct SearchResultsModel {
	let results: [SearchResultModel]
	let error: String?

	init(object: Any) throws {
		guard let dictionary = object as? [String : Any] else {
			throw ResponseError.unexpectedObject(object)
		}
		var results: [SearchResultModel] = []
		let buffer = dictionary["results"] as? [[String : Any]] ?? []
		for buf in buffer {
			guard let result = try? SearchResultModel(object: buf) else {
				continue
			}
			results.append(result)
		}

		let error = dictionary["error"] as? String

		self.results = results
		self.error = error
	}

}
