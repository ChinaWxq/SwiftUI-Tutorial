//
//  MapView.swift
//  Test
//
//  Created by wuxueqian on 2020/8/10.
//

import SwiftUI
import MapKit

/*
  在SwiftUI中使用UIView子类，需要将视图包装在UIViewRepresentable协议的SwiftUI视图中。
  makeUIView(context:) - 创建view
  updateUIView(_,context:) - 更新view
 */

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: landmarkData[0].locationCoordinate)
    }
}
