//
//  MovieSourceModel.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

struct MovieSourceModel {
	let displayName: String
	let link: String

	init(object: Any) throws {
		guard let dictionary = object as? [String : Any],
			let displayName = dictionary["display_name"] as? String,
			let link = dictionary["link"] as? String else {
				throw ResponseError.unexpectedObject(object)
		}

		self.displayName = displayName
		self.link = link
	}
}
