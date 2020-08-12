//
//  CategoryRow.swift
//  Test
//
//  Created by wuxueqian on 2020/8/12.
//

import SwiftUI

struct CategoryRow: View {
    var items: [Landmark]
    var categoryName: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(alignment: .top) {
                    ForEach(items) { item in
                        NavigationLink(
                            destination: LandmarkDetail(landmark: item),
                            label: {
                                CategoryRowItem(landmark: item)
                            })
                    }
                }
            })
            .frame(height: 185)
            .padding(.bottom, 5)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(items: Array(landmarkData.prefix(3)), categoryName: landmarkData[0].category.rawValue)
    }
}

struct CategoryRowItem: View {
    var landmark: Landmark
    var body: some View {
        VStack(alignment: .leading) {
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width:155, height:155)
                .cornerRadius(5)
            Text(landmark.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}
