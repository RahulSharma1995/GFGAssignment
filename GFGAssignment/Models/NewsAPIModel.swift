//
//  NewsAPIModel.swift
//  GFGAssignment
//
//  Created by Rahul Sharma on 30/04/22.
//

import Foundation
struct NewsAPIModel : Decodable {
	let status : String?
	let feed : Feed?
	let items : [Items]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case feed = "feed"
		case items = "items"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
		items = try values.decodeIfPresent([Items].self, forKey: .items)
	}

}
