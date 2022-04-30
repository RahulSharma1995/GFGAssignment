//
//  ExpendedCell.swift
//  GFGiOSChalleng
//
//  Created by Rahul Sharma on 29/04/22.
//

import SwiftUI

struct ExpendedCell: View {
    
    let item: ItemModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            AsyncImage(url: item.thumbnail) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let returnImage):
                    returnImage
                        .resizable()
                        .padding(.horizontal, 0.0)
                        .frame(height: 300, alignment: .top)
                case .failure:
                    Image(systemName: "questionmark")
                        .font(.title2)
                        .frame(alignment:.center)
                        .foregroundColor(.red)
                default:
                    Image(systemName: "questionmark")
                        .font(.title2)
                        .frame(alignment:.center)
                        .foregroundColor(.red)
                }
            }
            
            Text(item.title)
                .font(.body)
                .foregroundColor(.green)
                .padding(.horizontal, 10.0)
            Spacer()
            Divider()
            
            HStack(alignment: .center, spacing: 20) {
                Text(item.pubDate)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(item.pubTime)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

struct ExpendedCell_Previews: PreviewProvider {
    static let item = ItemModel(title: "ABC", pubDate: "kmdkm", pubTime: "mc", link: "", guid: "", author: "", thumbnail: nil, description: "", content: "", categories: [])

    static var previews: some View {
        ExpendedCell(item: item)
    }
}
