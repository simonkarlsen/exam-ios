
import UIKit
import MapKit

class SecondViewController: UIViewController {
    let locManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    public var completionHandler: ((String?) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .lightGray
        print("viewDidLoad")
        setUpMapView()
//        LocationManager.shared.startLocationUpdater { () -> ()? in
//            self.showLocation()
//        }
        
    }
//
//     func viewDidAppear() {
//        LocationManager.shared.startLocationUpdater { () -> ()? in
//            self.showLocation()
//        }
//    }
//
//    func showLocation() {
//        print("before if let currentLocation")
//        if let currentLocation = LocationManager.shared.currentLocation{
//
//            let coordinate = currentLocation.location.coordinate
//
//            self.latitudeLabel.text = "Latitude: \(coordinate.latitude)"
//
//            print("Latitude: \(coordinate.latitude)")
//
//            self.longitudeLabel.text = "Longitude: \(coordinate.longitude)"
//
//            print("Longitude: \(coordinate.longitude)")
//
//            setUpMapView()
//        }
//    }
    
    func setUpMapView() {
         mapView.showsUserLocation = true
         mapView.showsCompass = true
         mapView.showsScale = true
        
      }

    
    @IBOutlet private var mapView: MKMapView!
    

 
}
