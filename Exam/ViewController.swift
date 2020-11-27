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

protocol DataDelegate {
    func printString(string: String)
    
}


class ViewController: UIViewController, UITableViewDelegate, DataDelegate {
    func printString(string: String) {
        print("printing delegate string")
        print(string)
    }
    

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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        getHK()
    }
    
    func getHK() {
        print("counter:)")
        print(counter)
        if counter == 1 {
            getUserLocationWithCoordinates(latitude: 59.91116, longitude: 10.74481)
            
            counter = 0
        }
        else {
            print("Already updated weather for HK")
//            getCurrentUserLocation(updateLocationAgain: false)
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
    
    
    public func getCurrentUserLocation(updateLocationAgain: Bool) {
        if(updateLocationAgain) {
            LocationManager.shared.startLocationUpdater { () -> ()? in
                self.showLocation()
            }
        }
        else {
        
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
        LocationManager.shared.stopLocationUpdater()
    }
    
    public func getUserLocationWithCoordinates(latitude lat: Double, longitude lon: Double) {
        let weatherReq = WeatherManager(latitude: lat, longitude: lon)
        Items.sharedInstance.myLocationLat = lon
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
                    self?.locationLabel.text = "Din lokasjon: HK"
                    self?.tableView.reloadData()
                }
            }
        }
    }
   
}

//MARK: - UITableViewDataSource, WeatherManagerDelegate
extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Items.sharedInstance.sharedArray.count")
        print(Items.sharedInstance.sharedArray.count)
        return Items.sharedInstance.sharedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let customCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        let weatherModelList = Items.sharedInstance.sharedArray[indexPath.row]

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

        return customCell

    }
    
}


    





