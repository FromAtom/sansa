//
//  SearchResultModel.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

struct SearchResultModel {
	let id: Int
	let title: String
	let releaseYear: Int
	let poster120x171: String
//	let poster240x342: String
//	let poster400x570: String

	init(object: Any) throws {
		guard let dictionary = object as? [String : Any],
			let id = dictionary["id"] as? Int,
			let title = dictionary["title"] as? String,
			let releaseYear = dictionary["release_year"] as? Int,
			let poster120x171 = dictionary["poster_120x171"] as? String else {
				throw ResponseError.unexpectedObject(object)
		}

		self.id = id
		self.title = title
		self.releaseYear = releaseYear
		self.poster120x171 = poster120x171
	}
}
