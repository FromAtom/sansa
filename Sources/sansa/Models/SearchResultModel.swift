//
//  SearchResultModel.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Decodable

struct SearchResultModel {
	let id: Int
	let title: String
	let releaseYear: Int
	let poster120x171: String
	let poster240x342: String
	let poster400x570: String
}

extension SearchResultModel: Decodable {

	static func decode(_ json: Any) throws -> SearchResultModel {
		return try SearchResultModel(
			id: json => "id",
			title: json => "title",
			releaseYear: json => "release_year",
			poster120x171: json => "poster_120x171",
			poster240x342: json => "poster_240x342",
			poster400x570: json => "poster_400x570"
		)
	}

}
