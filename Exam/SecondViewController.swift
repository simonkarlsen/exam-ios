import UIKit
import MapKit
import Foundation


struct LocationData {
    var weather: String
    var myLocationLat: Double
    var myLocationLon: Double
}

struct LocationDataArray {
    static var sharedInstance = LocationDataArray()
    var dataArray = [LocationData]()
}


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
    
    var isSwitchOn: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print("viewDidLoad")
        setUpMapView()
        print("after setUpMapView")
      
        print("after giveDataToCustomView")
        LocationManager.shared.startLocationUpdater { () -> ()? in
            self.showLocation()
        }
        
        let weatherDataFromPin = LocationData(weather: Items.sharedInstance.sharedArray[1].imageString, myLocationLat: Items.sharedInstance.myLocationLat, myLocationLon: Items.sharedInstance.myLocationLon)
        LocationDataArray.sharedInstance.dataArray.removeAll()
        LocationDataArray.sharedInstance.dataArray.append(weatherDataFromPin)
        
        print("LocationDataArray.sharedInstance.dataArray[0].myLocationLat: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLat)")
        print("LocationDataArray.sharedInstance.dataArray[0].myLocationLon: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLon)")
        print("LocationDataArray.sharedInstance.dataArray[0].weather: \(LocationDataArray.sharedInstance.dataArray[0].weather)")
    }
    
    
    @IBAction func switchDidChange( _ sender: UISwitch) {
        if sender.isOn {
            isSwitchOn = true
            print("sender is on")
            view.backgroundColor = .blue
            customDelegate?.giveDataToCustomView("I present you this data, good sir: Sender is on")
            
        } else {
            isSwitchOn = false
            print("sender is not on")
            view.backgroundColor = .black
            
            getCurrentLocation()
            
            
            
            customDelegate?.giveDataToCustomView("I present you this data, good sir: Sender is off")
        }
    }

    func setUpMapView() {
         mapView.showsUserLocation = true
         mapView.showsCompass = true
         mapView.showsScale = true
        
      }
    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        
        if isSwitchOn == true {
        
        let location = sender.location(in: self.mapView)
//
        let locationCoordinates = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
       
        
        let lat: Double = locationCoordinates.latitude
        let lon: Double = locationCoordinates.longitude
        
        let latToString = String(lat)
        let lonToString = String(lon)
        
        
        annotation.title = "Your pin location"
        annotation.subtitle = "\(latToString), \(lonToString)"
        
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(annotation)
            
//        vc.getUserLocationWithCoordinates(latitude: lat, longitude: lon)
            
        getDataByCoordinates(latitude: lat, longitude: lon)
            
        } else {
            print("cannot add pin since switch is not on")
        }
    }
    
    func getDataByCoordinates(latitude lat: Double, longitude lon: Double) {
        print("in getDataByCoordinates")
        let weatherReq = WeatherManager(latitude: lat, longitude: lon)
        Items.sharedInstance.myLocationLat = lon
        Items.sharedInstance.myLocationLon = lon
        weatherReq.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weatherProps):
//                MapPinData.sharedInstance.myLocationLat = lat
//                MapPinData.sharedInstance.myLocationLon = lon
//                MapPinData.sharedInstance.weather = weatherProps[1].imageString
                let weatherDataFromPin = LocationData(weather: weatherProps[1].imageString, myLocationLat: lat, myLocationLon: lon)
                LocationDataArray.sharedInstance.dataArray.removeAll()
                LocationDataArray.sharedInstance.dataArray.append(weatherDataFromPin)
            }
        }
//        print("getDataByCoordinates: LocationDataArray.sharedInstance.dataArray[0].myLocationLat: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLat)")
//        print("getDataByCoordinates: LocationDataArray.sharedInstance.dataArray[0].myLocationLon: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLon)")
//        print("getDataByCoordinates: LocationDataArray.sharedInstance.dataArray[0].weather: \(LocationDataArray.sharedInstance.dataArray[0].weather)")
    }
    
    fileprivate func getCurrentLocation() {
        
        if let currentLocation = LocationManager.shared.currentLocation{
            
            let coordinate = currentLocation.location.coordinate
            
            let lat = coordinate.latitude
            let lon = coordinate.longitude
            
            let weatherReq = WeatherManager(latitude: lat, longitude: lon)
            Items.sharedInstance.myLocationLat = lat
            Items.sharedInstance.myLocationLon = lon
            weatherReq.getWeather{[weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let weatherProps):
                    
                    let weatherDataFromPin = LocationData(weather: weatherProps[1].imageString, myLocationLat: lat, myLocationLon: lon)
                    LocationDataArray.sharedInstance.dataArray.removeAll()
                    LocationDataArray.sharedInstance.dataArray.append(weatherDataFromPin)
                }
            }
        }
//        print("getDataByCoordinates: LocationDataArray.sharedInstance.dataArray[0].myLocationLat: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLat)")
//        print("getDataByCoordinates: LocationDataArray.sharedInstance.dataArray[0].myLocationLon: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLon)")
//        print("getDataByCoordinates: LocationDataArray.sharedInstance.dataArray[0].weather: \(LocationDataArray.sharedInstance.dataArray[0].weather)")
    
//        LocationManager.shared.stopLocationUpdater()
    }
    
    
    func showLocation() {
        print("before if let currentLocation")
        if let currentLocation = LocationManager.shared.currentLocation{
            
            let coordinate = currentLocation.location.coordinate
           
            print("showLocation - Latitude: \(coordinate.latitude)")
            
            print("showLocation - Longitude: \(coordinate.longitude)")
            
        }
    }

}
