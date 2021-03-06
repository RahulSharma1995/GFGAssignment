//
//  NewsListView.swift
//  GFGAssignment
//
//  Created by Rahul Sharma on 30/04/22.
//

import SwiftUI

struct NewsListView: View {
    
    @EnvironmentObject var newsListViewModel: NewsListViewModel    
    var body: some View {
        List {
            if let item = newsListViewModel.items.first {
                ExpendedCell(item: item)
                    .listRowInsets(EdgeInsets())
            }
            ForEach(newsListViewModel.items) { item in
                Section {
                    NewsCell(item: item)
                        .frame(height: 100)
                        .padding(.horizontal, 0.0)
                        .listRowInsets(EdgeInsets())
                    }
            }
            .onDelete(perform: newsListViewModel.delete)
            .onMove(perform: newsListViewModel.move)
        }
        .refreshable {
            newsListViewModel.getNewsData()
        }
        .navigationTitle("GeeksForGeeks")
        .toolbar {
            EditButton()
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewsListView()
        }
        .environmentObject(NewsListViewModel())
    }
}
