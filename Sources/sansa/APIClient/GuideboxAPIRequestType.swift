//
//  GuideboxAPIRequestType.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

import Foundation
import APIKit
import Decodable

protocol GuideboxAPIRequestType: Request {
	var apiKey: String { get }
}

extension GuideboxAPIRequestType {

	var baseURL: URL {
		let endpoint: String = "http://api-public.guidebox.com/v2"
		return URL(string: endpoint)!
	}

	var apiKey: String {
		let env = ProcessInfo.processInfo.environment
		guard let key = env["API_KEY"] else {
			fatalError("ENV['API_KEY'] is not set.")
		}

		return key
	}

	func intercept(urlRequest: URLRequest) throws -> URLRequest {
		var request = urlRequest

		request.setValue("Bearer " + apiKey, forHTTPHeaderField: "Authorization")
		request.setValue("JP", forHTTPHeaderField: "Guidebox-Region")
		return request
	}

}
