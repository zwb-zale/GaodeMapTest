//
//  ViewModel.swift
//  GaodeMapTest
//
//  Created by zwb on 2021/10/27.
//

import Combine
import Foundation
import AMapNaviKit
public func delay(by delayTime: TimeInterval, qosClass: DispatchQoS.QoSClass? = nil,
                  _ closure: @escaping () -> Void) {
    let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : .main
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}
class ViewModel: ObservableObject {
    @Published var mapView: MAMapView = MAMapView()
    @Published var mapType: MAMapType = .standard
    @Published var mapZoom: CGFloat = 5.0
    @Published var centerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var carFenxiAnnotatin: MAPointAnnotation = MAPointAnnotation()
    @Published var movingAnnotation : MAAnimatedAnnotation = MAAnimatedAnnotation()
    @Published var carIsMoving: Bool = false
    
    @Published var searchPointDatas: [CLLocationCoordinate2D] = [CLLocationCoordinate2D] ()
    
    
    func change_map_type(_ type: MAMapType) {
        mapType = type
        mapView.mapType = mapType
    }
    
    func move_car() {
        print("searchPointDatas:\(searchPointDatas.count)")
        if searchPointDatas.count > 0{
            mapView.removeAnnotation(movingAnnotation)
            movingAnnotation = MAAnimatedAnnotation.init()
            movingAnnotation.coordinate = searchPointDatas.first!
            mapView.addAnnotation(movingAnnotation)
            
            movingAnnotation.coordinate = searchPointDatas[0];
            carIsMoving = true
            movingAnnotation.addMoveAnimation(withKeyCoordinates:&(searchPointDatas), count: UInt(searchPointDatas.count), withDuration: 10, withName: nil, completeCallback:mmoveCallBack);
        }
        
    }
    func mmoveCallBack(isFinished: Bool) {
        carIsMoving = false
    }
    func stop_car(){
        for item in self.movingAnnotation.allMoveAnimations() {
            let animation = item
            animation.cancel()
        }
        carIsMoving = false
    }
    
    func search_route_point() {
        self.searchPointDatas = [
            CLLocationCoordinate2D(latitude: 39.855539, longitude: 116.119037),
            CLLocationCoordinate2D(latitude: 39.88539, longitude: 116.250285),
            CLLocationCoordinate2D(latitude: 39.805479, longitude: 116.180859),
            CLLocationCoordinate2D(latitude: 39.788467, longitude: 116.226786),
            CLLocationCoordinate2D(latitude: 40.001442, longitude: 116.353915),
            CLLocationCoordinate2D(latitude: 39.989105, longitude: 116.360200)]
        self.drawPointLine()
        
    }
    
    func drawPointLine() {
        if searchPointDatas.count > 0{
            let line: MAPolyline = MAPolyline(coordinates: &self.searchPointDatas, count: UInt(self.searchPointDatas.count))
            self.mapView.remove(line)
            self.mapView.add(line)
            self.mapView.setCenter(self.searchPointDatas[0], animated: true)
            self.mapView.setZoomLevel(12.5, animated: true)
        }
        
    }
}

