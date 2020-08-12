//
//  PageViewController.swift
//  Test
//
//  Created by wuxueqian on 2020/8/12.
//

import SwiftUI
import UIKit

/*
 在SwiftUI中表示UIKit视图和视图控制器，需要分别遵循UIViewRepresentable和UIViewControllerRepresentable协议。SwiftUI管理他们的生命周期。
 UIKit视图控制器的SwiftUI视图可以定义SwiftUI管理的Coordinator类型，作为SwiftUI Context的一部分内容。
 */

struct PageViewController: UIViewControllerRepresentable {
    
    // 绑定PageView的currentPage属性
    @Binding var currentPage: Int
    
    // 轮播视图控制器
    var controllers: [UIViewController]
    
    
    /// Creates the custom instance that you use to communicate changes from your view controller to other parts of your SwiftUI interface.
    /// 创建用于将更改从ViewController传递到SwiftUI界面的自定义实例。
    /// 我们可以用这个 coordinator 实现常见的 Cocoa 模式，例如代理、数据源以及通过 target-action 响应用户事件。
    /// - Returns: Coordinator实例
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 创建视图控制器，仅初始化调用一次
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if self.currentPage + 1 == self.controllers.count {
                self.currentPage = 0
            } else {
                self.currentPage = self.currentPage + 1
            }
        }
        return pageViewController
    }
    
    // 更新视图控制器
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([controllers[currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    // 协调器，实现需要的协议
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: PageViewController
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return parent.controllers.last
            }
            return parent.controllers[index - 1];
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                return parent.controllers.first
            }
            return parent.controllers[index + 1];
        }
        
        // 处理结束滑动更新index
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
            let visibleViewController = pageViewController.viewControllers?.first,
            let index = parent.controllers.firstIndex(of: visibleViewController)
            {
                parent.currentPage = index
            }
        }
        
    }
}
