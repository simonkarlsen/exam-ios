
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

}
