//
//  GaodeMapView.swift
//  GaodeMapTest
//
//  Created by zwb on 2021/10/27.
//

import SwiftUI
import AMapNaviKit

class myAnnotation: MAAnimatedAnnotation {
    
}

struct GaodeMapView: UIViewRepresentable {
    @EnvironmentObject var viewModel: ViewModel
    
    typealias UIViewType = MAMapView
    func makeUIView(context: Context) -> MAMapView {
        let mapView = viewModel.mapView
        mapView.delegate = context.coordinator
        mapView.zoomLevel = viewModel.mapZoom
        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
        mapView.mapType = viewModel.mapType
        return mapView
    }
    
    func updateUIView(_ uiView: MAMapView, context: Context) {
        print("i update......")
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator: NSObject, MAMapViewDelegate {
        var parent: GaodeMapView

        init(_ parent: GaodeMapView) {
            self.parent = parent
        }
        
        func mapInitComplete(_ mapView: MAMapView!) {
            print("地图初始化完成!")
        }
        
        
        func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
            parent.viewModel.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
            
            if annotation.isKind(of: MAPointAnnotation.self) && !annotation.isKind(of: MAUserLocation.self) {
                let pointReuseIndetifier = "pointReuseIndetifier"
                var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
                
                if annotationView == nil {
                    annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
                }
                
                annotationView!.canShowCallout = true
                annotationView!.animatesDrop = true
                annotationView!.isDraggable = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView!.image = UIImage(named: "car_online")
                
                return annotationView!
            }
            
            return nil
        }
        func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
            if overlay.isKind(of: MAPolyline.self) {
                let polylineRenderer: MAPolylineRenderer = MAPolylineRenderer(overlay: overlay)
                polylineRenderer.lineWidth = 11.0
                polylineRenderer.strokeColor = UIColor.green

                return polylineRenderer
            }
            if overlay.isKind(of: MACircle.self) {
                let renderer: MACircleRenderer = MACircleRenderer(overlay: overlay)
                renderer.lineWidth = 8.0
                renderer.strokeColor = UIColor.green
                renderer.fillColor = UIColor.red.withAlphaComponent(0.4)
                
                return renderer
            }
            return nil
        }
    }
    
    
    
    
}

