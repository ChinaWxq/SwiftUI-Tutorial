//
//  PageView.swift
//  Test
//
//  Created by wuxueqian on 2020/8/12.
//

import SwiftUI


struct PageView<Page: View>: View {
    
    // 当前页面索引
    @State var currentPage = 0
    
    // 视图数组
    var viewControllers: [UIHostingController<Page>]
    
    init(_ views: [Page]) {
        // 泛型初始化接受一个视图数组，包裹在UIHostingController中，作为UIViewController的子类用于在SwiftUI展示
        self.viewControllers = views.map { UIHostingController(rootView: $0)}
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(currentPage: $currentPage, controllers: viewControllers)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.bottom, 10)
                .offset(x: 150)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(features.map{ FeatureCard(landmark: $0)})
    }
}
