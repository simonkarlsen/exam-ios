//
//  ViewController.swift
//  Exam
//

//

import UIKit
import MapKit

struct Items {
    static var sharedInstance = Items()
    var sharedArray = [WeatherModel]()
    
    var myLocationLat: Double = 0.0
    var myLocationLon: Double = 0.0
}

//class MapPin: NSObject, MKAnnotation {
//   let title: String?
//   let locationName: String
//   let coordinate: CLLocationCoordinate2D
//init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
//      self.title = title
//      self.locationName = locationName
//      self.coordinate = coordinate
//   }
//}

class ViewController: UIViewController, UITableViewDelegate {
    
//    var weatherManager = WeatherManager()
    var getHKLocaton: Bool = true
    var counter: Int = 1
    
    var sharedArrayList = Items.sharedInstance.sharedArray
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    var listOfWeather = [WeatherModel]()

    
    var listOfWeatherProperties = [WeatherResponse]()
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        
        
    
        LocationManager.shared.startLocationUpdater { () -> ()? in
            self.showLocation()
        }
        
        getHK()
//        weatherManager.delegate = self
    }
    
    func showLocation() {
        print("before if let currentLocation")
        if let currentLocation = LocationManager.shared.currentLocation{
            
            let coordinate = currentLocation.location.coordinate
           
            print("showLocation - Latitude: \(coordinate.latitude)")
            
            print("showLocation - Longitude: \(coordinate.longitude)")
            
        }
    }
    
    @objc func didGetNotification(_ notification: Notification) {
        let text = notification.object as! String?
        label.text = text
    }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "second") as! SecondViewController
        vc.modalPresentationStyle = .fullScreen
//        vc.completionHandler = { text in
//            self.label.text = text
//        }
        present(vc, animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        getHK()
    }

    
    func getHK() {
        print("counter:)")
        print(counter)
        if counter == 1 {
            let weatherReq = WeatherManager(latitude: 59.91116, longitude: 10.74481)
            Items.sharedInstance.myLocationLat = 59.91116
            Items.sharedInstance.myLocationLon = 10.74481
            weatherReq.getWeather{[weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let weatherProps):
                    self?.listOfWeather.append(contentsOf: weatherProps)
                    Items.sharedInstance.sharedArray.removeAll()
                    Items.sharedInstance.sharedArray.append(contentsOf: weatherProps)
                    self?.sharedArrayList.removeAll()
                    self?.sharedArrayList.append(contentsOf: weatherProps)
                    DispatchQueue.main.async {
                        self?.locationLabel.text = "Din lokasjon: HK"
                        self?.tableView.reloadData()
                    }
                }
            }
            counter = 0
        }
        else {
            print("Already updated weather for HK")
            
            
            if let currentLocation = LocationManager.shared.currentLocation{
                
                let coordinate = currentLocation.location.coordinate
                
            
                var lat = coordinate.latitude
                var lon = coordinate.longitude
            
                let weatherReq = WeatherManager(latitude: lat, longitude: lon)
                Items.sharedInstance.myLocationLat = lat
                Items.sharedInstance.myLocationLon = lon
                weatherReq.getWeather{[weak self] result in
                switch result {
                case .failure(let error):
                        print(error)
                case .success(let weatherProps):
                        self?.listOfWeather.append(contentsOf: weatherProps)
                        Items.sharedInstance.sharedArray.removeAll()
                        Items.sharedInstance.sharedArray.append(contentsOf: weatherProps)
                        self?.sharedArrayList.removeAll()
                        self?.sharedArrayList.append(contentsOf: weatherProps)
                        DispatchQueue.main.async {
                            self?.locationLabel.text = "Din lokasjon: " + String(lat) + ", " + String(lon)
                            
                        self?.tableView.reloadData()
                        }
                    }
                }
            }
            
        }
        
    }
   
}

//MARK: - UITableViewDataSource, WeatherManagerDelegate
extension ViewController: UITableViewDataSource {
    
    
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        print("in didUpdateWeather")
//        print(weather.instant)
////        DispatchQueue.main.async {
////            // because of the closure, you have to add "self" before temperatureLabel..
////            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
////            self.temperatureLabel.text = weather.
////            self.cityLabel.text =
////        }
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Items.sharedInstance.sharedArray.count")
        print(Items.sharedInstance.sharedArray.count)
        return Items.sharedInstance.sharedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
            let customCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        let weatherModelList = Items.sharedInstance.sharedArray[indexPath.row]
        
//        let rain = listOfWeather[indexPath.row].rain
//        let summary = listOfWeather[indexPath.row].summary
//        let temperature = listOfWeather[indexPath.row].temperature
//        let rainUnits = listOfWeather[indexPath.row].rainUnits
//        let tempUnits = listOfWeather[indexPath.row].tempUnits
        let titles = ["Nå", "Neste time", "Neste 6 timer", "Neste 12 timer"]
        let tempWeather = ["Temperatur", "Vær", "Vær", "Vær"]
        
        let rain = weatherModelList.rain
        let summary = weatherModelList.summary
        let temperature = weatherModelList.temperature
        let rainUnits = weatherModelList.rainUnits
        let tempUnits = weatherModelList.tempUnits
        
        print("rain: \(rain)")
        print("summary: \(summary)")
        
        customCell.hourTitleLabel.text = titles[indexPath.row]
        customCell.rainAmount.text = rain
        customCell.titleLabel.text = tempWeather[indexPath.row]
        customCell.weather.text = summary
        customCell.temp.text = temperature
        customCell.rainUnit.text = rainUnits
        customCell.tempUnit.text = tempUnits

//        cell.textLabel?.text = String(weatherList.summary1Hour)
        return customCell
//        return cell
    }
    
   
}

//extension ViewController: WeatherManagerDelegate {
//    // adopted delegate from WeatherManager
//    /*func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
//        print(weather.temperature)
//    }*/
//
//    // better convention than the one above:
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        // print(weather.temperature)
//        DispatchQueue.main.async {
//            // because of the closure, you have to add "self" before temperatureLabel..
//            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
//            self.temperatureLabel.text = weather.temperatureString
//            self.cityLabel.text = weather.cityName
//
//
//        }
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}

    

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
    
    @IBAction func didTapSave() {
//        completionHandler?(field.text)
//        NotificationCenter.default.post(name: Notification.Name("text"), object: field.text)
        dismiss(animated: true, completion: nil)
    }
 
}




