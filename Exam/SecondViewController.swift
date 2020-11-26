
import UIKit
import MapKit


class SecondViewController: UIViewController {
    let locManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
//    var datadelegate: DataDelegate?
//    var moveHere: String = ""
    var customDelegate: CustomDelegate?
    var customView: WeatherCustomView?
//
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet private var mapView: MKMapView!
    
    public var completionHandler: ((String?) -> Void)?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .lightGray
        print("viewDidLoad")
        setUpMapView()
        print("after setUpMapView")
        customDelegate?.giveDataToCustomView("I present you this data, good sir")
        print("after giveDataToCustomView")
    }
    
   
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
    

    func setUpMapView() {
         mapView.showsUserLocation = true
         mapView.showsCompass = true
         mapView.showsScale = true
        
      }

}
