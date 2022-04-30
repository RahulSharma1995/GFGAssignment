//
//  NewsCell.swift
//  GFGiOSChalleng
//
//  Created by Rahul Sharma on 29/04/22.
//

import SwiftUI

struct NewsCell: View {
//    let url = URL(string: "https://picsum.photos/200/400")
    let item: ItemModel
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                        .font(.body)
                        .foregroundColor(.green)
                    HStack {
                        Text(item.pubDate)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Text(item.pubTime)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
            }
            .padding([.top, .bottom , .leading, .trailing], 10.0)
            Spacer()
            AsyncImage(url: item.thumbnail) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let returnImage):
                    returnImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100, alignment: .trailing)
                        .background(.orange)
                case .failure:
                    Image(systemName: "questionmark")
                        .font(.headline)
                default:
                    Image(systemName: "questionmark")
                        .font(.headline)
                }
            }
        }
    }
}

struct NewsCell_Previews: PreviewProvider {
    static let item = ItemModel(title: "ABC", pubDate: "kmdkm", pubTime: "mc", link: "", guid: "", author: "", thumbnail: nil, description: "", content: "", categories: [])
    static var previews: some View {
        NewsCell(item: item)
    }
}
