//
//  FeatureCard.swift
//  Test
//
//  Created by wuxueqian on 2020/8/12.
//

import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark
    var body: some View {
        landmark.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(TextOverlay(landmark: landmark))
    }
}

struct TextOverlay: View {
    var landmark: Landmark
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(Color.clear)
            VStack(alignment: .leading, spacing: 0, content: {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            })
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: landmarkData[0])
    }
}
