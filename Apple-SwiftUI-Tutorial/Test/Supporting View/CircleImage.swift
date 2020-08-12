//
//  CircleImage.swift
//  Test
//
//  Created by wuxueqian on 2020/8/10.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        VStack {
            image
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4.0))
                .shadow(radius: 10)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
