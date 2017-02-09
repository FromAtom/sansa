//
//  GuideboxAPIRequestType.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
}

protocol GuideboxAPIRequestType {
	var baseURL: URL { get }
	var endpoint: String { get }
	var path: String { get }
	var apiKey: String { get }
	var headers: [String : String] { get }
	var query: [String : String] { get }
	var method: HTTPMethod { get }

	func uriEncode(_ str: String) -> String
}

extension GuideboxAPIRequestType {

	var endpoint: String {
		return "http://api-public.guidebox.com/v2"
	}

	var baseURL: URL {
		return URL(string: endpoint)!
	}

	var apiKey: String {
		let env = ProcessInfo.processInfo.environment
		guard let key = env["API_KEY"] else {
			fatalError("ENV['API_KEY'] is not set.")
		}

		return key
	}

	var headers: [String : String] {
		return [
			"Authorization" : apiKey,
			//"Guidebox-Region" : "JP"
		]
	}

	func uriEncode(_ str: String) -> String {
		return str.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
	}

}

