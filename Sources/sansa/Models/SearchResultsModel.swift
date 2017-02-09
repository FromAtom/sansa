//
//  SearchResultsModel.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Decodable

struct SearchResultsModel {
	let results: [SearchResultModel]?
	let error: String?
}

extension SearchResultsModel: Decodable {

	static func decode(_ json: Any) throws -> SearchResultsModel {
		return try SearchResultsModel(
			results: json =>? "results",
			error: json =>? "error"
		)
	}

}
