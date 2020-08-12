//
//  CategoryHome.swift
//  Test
//
//  Created by wuxueqian on 2020/8/12.
//

import SwiftUI

struct CategoryHome: View {
    @State var showFavorite = false // 是否仅展示喜欢列表
    
    var categories: [String: [Landmark]] {
        Dictionary(grouping: landmarkData, by: {$0.category.rawValue} )
    }
    
    var body: some View {
        NavigationView {
            List {
                PageView(features.map{ FeatureCard(landmark: $0)})
                    .aspectRatio(1.5, contentMode: .fit)
                    .listRowInsets(EdgeInsets())

                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(items: self.categories[key]!, categoryName: key)
                }
                .listRowInsets(EdgeInsets()) // List列表item边距为0

                NavigationLink(destination: LandmarkList()) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featured"))
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(UserData())
    }
}
