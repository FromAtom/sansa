//
//  MovieDetailModel.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

struct MovieDetailModel {
	let id: Int
	let title: String
	let releaseYear: Int
	let poster120x171: String
	let sources: [MovieSourceModel]
	let poster240x342: String
	let poster400x570: String

	init(object: Any) throws {
		guard let dictionary = object as? [String : Any],
			let id = dictionary["id"] as? Int,
			let title = dictionary["title"] as? String,
			let releaseYear = dictionary["release_year"] as? Int,
			let poster120x171 = dictionary["poster_120x171"] as? String,
			let poster240x342 = dictionary["poster_240x342"] as? String,
			let poster400x570 = dictionary["poster_400x570"] as? String else {
				throw ResponseError.unexpectedObject(object)
		}

		let freeWebSource = dictionary["free_web_sources"] as? [[String : Any]] ?? []
		let subscriptionWebSource = dictionary["subscription_web_sources"] as? [[String : Any]] ?? []
		let purchaseWebSource = dictionary["purchase_web_sources"] as? [[String : Any]] ?? []
		let tvEverywhereWebSource = dictionary["tv_everywhere_web_sources"] as? [[String : Any]] ?? []
		let sources = freeWebSource + subscriptionWebSource + purchaseWebSource + tvEverywhereWebSource

		var movieSourceModels: [MovieSourceModel] = []
		for source in sources {
			guard let movieSourceModel = try? MovieSourceModel(object: source) else {
				continue
			}
			movieSourceModels.append(movieSourceModel)
		}

		self.id = id
		self.title = title
		self.releaseYear = releaseYear
		self.poster120x171 = poster120x171
		self.poster240x342 = poster240x342
		self.poster400x570 = poster400x570
		self.sources = movieSourceModels
	}
}
