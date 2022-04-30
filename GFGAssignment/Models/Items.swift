//
//  Items.swift
//  GFGAssignment
//
//  Created by Rahul Sharma on 30/04/22.
//

import Foundation
struct Items : Decodable {
    
	let title : String
    let pubDate : String
	let link : String
	let guid : String
	let author : String
	let thumbnail : String
	let description : String
	let content : String
	let enclosure : Enclosure?
	let categories : [String]

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case pubDate = "pubDate"
		case link = "link"
		case guid = "guid"
		case author = "author"
		case thumbnail = "thumbnail"
		case description = "description"
		case content = "content"
		case enclosure = "enclosure"
		case categories = "categories"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
		pubDate = try values.decodeIfPresent(String.self, forKey: .pubDate) ?? ""
		link = try values.decodeIfPresent(String.self, forKey: .link) ?? ""
		guid = try values.decodeIfPresent(String.self, forKey: .guid) ?? ""
		author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
		description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
		content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
		enclosure = try values.decodeIfPresent(Enclosure.self, forKey: .enclosure)
		categories = try values.decodeIfPresent([String].self, forKey: .categories) ?? []
	}
    
    private func dateTimeFormat() -> (String,String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let datetime = formatter.date(from: pubDate) ?? Date()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateStr = formatter.string(from: datetime)
        formatter.dateFormat = "HH:mm a"
        let timeStr = formatter.string(from: datetime)
        return (dateStr,timeStr)
    }
    
    func toItemModel() -> ItemModel {
        let dateTime = dateTimeFormat()
        return ItemModel(title: title, pubDate: dateTime.0, pubTime: dateTime.1, link: link, guid: guid, author: author, thumbnail: URL(string: thumbnail), description: description, content: content, categories: categories)
    }

}
