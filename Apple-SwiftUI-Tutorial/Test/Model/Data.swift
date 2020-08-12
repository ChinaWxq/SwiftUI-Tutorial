//
//  Data.swift
//  Test
//
//  Created by wuxueqian on 2020/8/10.
//

import SwiftUI
import CoreLocation

let landmarkData: [Landmark] = load("landmarkData.json")
let features = landmarkData.filter { $0.isFeatured }

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    // 获取file路径
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        // 获取文件数据
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data) // JSON解析
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n(error)")
    }
}

/*
 单例模式 图片存储器
 */

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    var images: _ImageDictionary = [:]
    
    static var shared = ImageStore()
    
    fileprivate static var scale = 2
    
    func image(_ name: String) -> Image {
        let index = _guaranteeImage(name)
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }
    
    static func loadImage(_ name: String) -> CGImage {
        guard let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
              let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
              let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    // 访问时再加载资源文件
    func _guaranteeImage(_ name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name)  { return index }
        images[name] = ImageStore.loadImage(name)
        return images.index(forKey: name)!
    }

}
