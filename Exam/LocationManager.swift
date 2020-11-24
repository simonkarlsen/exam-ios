//
//  LocationManager.swift
//  Exam
//
//
//

import Foundation
import CoreLocation

struct LocationAddress {
    var location: CLLocation
    var city: String?
    var country: String?
    var address: String?
    
    init(location: CLLocation) {
        self.location = location
    }
}

typealias handler = () -> ()?


class LocationManager: NSObject {
    
    public static let shared = LocationManager()
    
    var locationUpdated: handler?
    
    var currentLocation: LocationAddress?
    
    
    private var locationManager: CLLocationManager = {
        
        let locationManager = CLLocationManager()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        
        return locationManager
    }()
    
    func startLocationUpdater (completed: handler?) {
        
        print("startLocationUpdater")
        
        locationUpdated = completed
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func startLocationUpdater() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let firstLocation = locations.first else { return }
        
        if CLLocationCoordinate2DIsValid(firstLocation.coordinate) {
            
            print("firstLocation.coordinate: \(firstLocation.coordinate)")
            
            currentLocation = .init(location: firstLocation)
            
            if let update = locationUpdated {
                update()
            }
        }
        
    }
}
