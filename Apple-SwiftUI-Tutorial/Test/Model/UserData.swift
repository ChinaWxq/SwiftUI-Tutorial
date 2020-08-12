//
//  UserData.swift
//  Test
//
//  Created by wuxueqian on 2020/8/10.
//

import SwiftUI
import Combine
/*
  ObservableObject是数据自定义对象，SwiftUI监视可能影响到视图的可观察对象的任何修改，并在修改之后对视图做出改变。
  SwiftUI会订阅你的ObservableObject，当数据更改时更新需要刷新的视图。
  ObservableObject需要发布（Published）对其数据的修改，以便订阅者获取修改。
 */
final class UserData: ObservableObject {
    @Published var landmarks = landmarkData
    @Published var showFavoritesOnly = false
}
