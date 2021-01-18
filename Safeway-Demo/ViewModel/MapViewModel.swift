//
//  MapViewModel.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/15/21.
//

import Foundation
import MapKit
import CoreLocation

class MapViewModel: NSObject, MKMapViewDelegate {
    let locationManager = CLLocationManager()
    let mapView:MKMapView!
    
    private var completionHandler:(String)->Void = {_ in }
    private var storeName: String?
    private var isLocationAuthorized = false
    
    init(screenSize: CGRect) {
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        super.init()
        self.mapView.delegate = self
        enableLocation()
        
    }
    
    func getNearestAddress(of storeName: String, with completion: @escaping((String) -> Void)) {
        enableLocation()
        self.completionHandler = completion
        self.storeName = storeName
    }
    
    func isLocationServiceEnabled() -> Bool {
        return isLocationAuthorized
    }
    
    private func enableLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func getAddress() {
        guard let storeName = storeName else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = storeName
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.completionHandler("\(response.mapItems[0].placemark)")
        }
    }
}

extension MapViewModel : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
            self.mapView.setRegion(region, animated: true)
            getAddress()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways , .authorizedWhenInUse:
            isLocationAuthorized = true
            break
        default:
            break
        }
    }
}
