//
//  GFGAssignmentApp.swift
//  GFGAssignment
//
//  Created by Rahul Sharma on 30/04/22.
//

import SwiftUI

@main
struct GFGAssignmentApp: App {
    
    @StateObject var newsListViewModel: NewsListViewModel = NewsListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NewsListView()
            }
            .environmentObject(newsListViewModel)
        }
    }
}
