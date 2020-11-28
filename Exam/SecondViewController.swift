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
    
    let vc = ViewController()
    
    
    @IBOutlet weak var customViewContainer: UIView!
    
    var weatherCustomView: WeatherCustomView!
    
    
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
        
        
        if let weatherCustomViewReference = Bundle.main.loadNibNamed("WeatherCustomView", owner: self, options: nil)?.first as? WeatherCustomView {
            
            customViewContainer.addSubview(weatherCustomViewReference)
            
            weatherCustomViewReference.frame.size.height = customViewContainer.frame.size.height
            
            weatherCustomViewReference.frame.size.width = customViewContainer.frame.size.width
            
            weatherCustomViewReference.customDelegate = self
            
            weatherCustomView = weatherCustomViewReference
            
        }
        
        
        
        
        let weatherDataFromPin = LocationData(weather: Items.sharedInstance.sharedArray[1].imageString, myLocationLat: Items.sharedInstance.myLocationLat, myLocationLon: Items.sharedInstance.myLocationLon)
        LocationDataArray.sharedInstance.dataArray.removeAll()
        LocationDataArray.sharedInstance.dataArray.append(weatherDataFromPin)
        
        print("LocationDataArray.sharedInstance.dataArray[0].myLocationLat: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLat)")
        print("LocationDataArray.sharedInstance.dataArray[0].myLocationLon: \(LocationDataArray.sharedInstance.dataArray[0].myLocationLon)")
        print("LocationDataArray.sharedInstance.dataArray[0].weather: \(LocationDataArray.sharedInstance.dataArray[0].weather)")
        
        DispatchQueue.main.async {
            self.weatherCustomView?.lonLabel.text = String(format: "%f", LocationDataArray.sharedInstance.dataArray[0].myLocationLat)
            
            self.weatherCustomView?.latLabel.text = String(format: "%f", LocationDataArray.sharedInstance.dataArray[0].myLocationLon)
            
            self.weatherCustomView?.imageView.image = UIImage(named: LocationDataArray.sharedInstance.dataArray[0].weather)
        }
    }
    
    
    @IBAction func switchDidChange( _ sender: UISwitch) {
        if sender.isOn {
            isSwitchOn = true
            print("sender is on")
            view.backgroundColor = .blue
            
            
        } else {
            isSwitchOn = false
            print("sender is not on")
            view.backgroundColor = .black
            
            getCurrentLocation()
            
            
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
                
                let weatherDataFromPin = LocationData(weather: weatherProps[1].imageString, myLocationLat: lat, myLocationLon: lon)
                LocationDataArray.sharedInstance.dataArray.removeAll()
                LocationDataArray.sharedInstance.dataArray.append(weatherDataFromPin)
                
                DispatchQueue.main.async {
                    self?.weatherCustomView?.lonLabel.text = String(format: "%f", lon)
                    
                    self?.weatherCustomView?.latLabel.text = String(format: "%f", lat)
                    
                    self?.weatherCustomView?.imageView.image = UIImage(named: weatherProps[1].imageString)
                }
            }
        }
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
                    
                    
                    DispatchQueue.main.async {
                        self?.weatherCustomView?.lonLabel.text = String(format: "%f", lon)
                        
                        self?.weatherCustomView?.latLabel.text = String(format: "%f", lat)
                        
                        self?.weatherCustomView?.imageView.image = UIImage(named: weatherProps[1].imageString)
                    }
                }
                
            }
        }
        
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


extension SecondViewController: CustomDelegate {
    func giveDataToCustomView(latitudeLabel: String, longitudeLabel: String, imageName: String) {
        print("latitudeLabel: \(latitudeLabel), longitudeLabel: \(longitudeLabel), imageName: \(imageName)")
    }
    
    
}
