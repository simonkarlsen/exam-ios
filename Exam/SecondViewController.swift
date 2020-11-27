
import UIKit
import MapKit


class SecondViewController: UIViewController {
    let locManager = CLLocationManager()
    let annotation = MKPointAnnotation()

    var customDelegate: CustomDelegate?
    var customView: WeatherCustomView?
    let vc = ViewController()

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet private var mapView: MKMapView!
    
    @IBOutlet weak var switchToggle: UISwitch!
    
    public var completionHandler: ((String?) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print("viewDidLoad")
        setUpMapView()
        print("after setUpMapView")
      
        print("after giveDataToCustomView")
    }
    
    @IBAction func switchDidChange( _ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = .blue
            customDelegate?.giveDataToCustomView("I present you this data, good sir: Sender is on")
            
        } else {
            print("sender is not on")
            view.backgroundColor = .black
            customDelegate?.giveDataToCustomView("I present you this data, good sir: Sender is off")
        }
    }

    func setUpMapView() {
         mapView.showsUserLocation = true
         mapView.showsCompass = true
         mapView.showsScale = true
        
      }
    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        
        let location = sender.location(in: self.mapView)
//
        let locationCoordinates = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        annotation.title = "Your pin location"
        
        let lat: Double = locationCoordinates.latitude
        let lon: Double = locationCoordinates.longitude
        
//        let latToString = String(lat)
//        let lonToString = String(lon)
//
        annotation.subtitle = "\(lat), \(lon)"
        
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(annotation)
    }

}
