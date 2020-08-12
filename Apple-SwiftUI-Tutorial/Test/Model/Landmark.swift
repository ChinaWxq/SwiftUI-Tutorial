//
//  Landmark.swift
//  Test
//
//  Created by wuxueqian on 2020/8/10.
//

import SwiftUI
import CoreLocation

struct Landmark: Codable, Hashable, Identifiable {
    
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var state: String
    var park: String
    var category: Category
    var isFavorite: Bool
    var isFeatured: Bool
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    var featureImage: Image? {
        guard isFeatured else  { return nil }
        
        return Image(ImageStore.loadImage("\(imageName)_feature"), scale: 2, label: Text(name))
    }
    
    enum Category: String, Codable, Hashable {
        case featured = "Featured"
        case lakes  = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
}

extension Landmark {
    var image: Image {
        ImageStore.shared.image(imageName)
    }
}

struct Coordinates: Codable, Hashable {
    var latitude: Double
    var longitude: Double
}
