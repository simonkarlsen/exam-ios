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
    
    let alertService = AlertService()
    
    var currentLocation: LocationAddress?
    
    let vc = ForecastController()
    
    
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
    
    func stopLocationUpdater() {
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
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print("locationManagerDidChangeAuthorization")
        
        LocationManager.shared.startLocationUpdater { () -> ()? in
            self.showLocation()
        }
        
        vc.getCurrentLocationData()
        print("vc.getCurrentLocationData()")
    }
}

//MARK: - Alert Handler
extension LocationManager {
    func presentAlert(message: String) {
        DispatchQueue.main.async {
            let alertToUser = self.alertService.alertUser(message: message)
            
            self.vc.present(alertToUser, animated: true)
        }
        
        return
    }
}

extension LocationManager {
    func showLocation() {
        print("before if let currentLocation")
        if let currentLocation = LocationManager.shared.currentLocation{
            
            let coordinate = currentLocation.location.coordinate
            
            print("showLocation - Latitude: \(coordinate.latitude)")
            
            print("showLocation - Longitude: \(coordinate.longitude)")
            
        }
    }
}
