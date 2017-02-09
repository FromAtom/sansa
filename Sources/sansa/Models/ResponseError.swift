//
//  ResponseError.swift
//  sansa
//
//  Created by FromAtom on 2017/02/09.
//
//

// Copy from
// https://github.com/ishkawa/APIKit/blob/01178a13ffd2d2cf3cda32ebbd86a3911859538e/Sources/APIKit/Error/ResponseError.swift

import Foundation

enum ResponseError: Error {
	/// Indicates the session adapter returned `URLResponse` that fails to down-cast to `HTTPURLResponse`.
	case nonHTTPURLResponse(URLResponse?)

	/// Indicates `HTTPURLResponse.statusCode` is not acceptable.
	/// In most cases, *acceptable* means the value is in `200..<300`.
	case unacceptableStatusCode(Int)

	/// Indicates `Any` that represents the response is unexpected.
	case unexpectedObject(Any)
}
