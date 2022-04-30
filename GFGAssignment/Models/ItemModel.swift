//
//  ItemModel.swift
//  GFGAssignment
//
//  Created by Rahul Sharma on 30/04/22.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title : String
    let pubDate : String
    let pubTime : String
    let link : String
    let guid : String
    let author : String
    let thumbnail : URL?
    let description : String
    let content : String
    let categories : [String]
}
