//
//  NewsListViewModel.swift
//  GFGAssignment
//
//  Created by Rahul Sharma on 30/04/22.
//

import Foundation
import Combine

class NewsListViewModel : ObservableObject {
    
    @Published var items: [ItemModel] = []
    
    var subscription = Set<AnyCancellable>()
    
    init(){
        getNewsData()
    }
    
    func getNewsData(){
        APIManager.shared.getData(endPoint: .news)
            .sink { complition in
                debugPrint("complition ::: \(complition)")
            } receiveValue: { [unowned self] news in
                guard let newsItems = news.items else { return }
                items.removeAll()
                newsItems.forEach { items.append($0.toItemModel())}
            }
            .store(in: &subscription)
    }
    
    func delete(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func move(indexSet: IndexSet, new: Int){
        items.move(fromOffsets: indexSet, toOffset: new)
    }
    
}
