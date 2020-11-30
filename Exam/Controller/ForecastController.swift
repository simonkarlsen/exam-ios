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
    var imageName: String = ""
}


class ForecastController: UIViewController, UITableViewDelegate {
    
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
        
        view.backgroundColor = .systemGray4
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        tableView.tableFooterView = UIView()
        
        LocationManager.shared.startLocationUpdater { () -> ()? in
            self.showLocation()
        }
        
        getData()
    }
    
    
//    just printing
    func showLocation() {
        print("before if let currentLocation")
        if let currentLocation = LocationManager.shared.currentLocation{
            
            let coordinate = currentLocation.location.coordinate
            
            print("showLocation - Latitude: \(coordinate.latitude)")
            
            print("showLocation - Longitude: \(coordinate.longitude)")
            
        }
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        getData()
    }
    
    func getCurrentLocationData() {
        
        print("getCurrentLocationData")
        
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
                    self?.presentAlert(message: "Nettverkskall feilet. Kunne ikke hente data for denne posisjonen.")
                case .success(let weatherProps):
                    self?.listOfWeather.append(contentsOf: weatherProps)
                    Items.sharedInstance.sharedArray.removeAll()
                    Items.sharedInstance.sharedArray.append(contentsOf: weatherProps)
                    self?.sharedArrayList.removeAll()
                    self?.sharedArrayList.append(contentsOf: weatherProps)
                    
                    
                    // Has to run on main thread. If these instructions run on a background thread, the app will crash
                    DispatchQueue.main.async {
                        self?.locationLabel.text = "Din lokasjon: " + String(lat) + ", " + String(lon)
                        
//                        print("self?.locationLabel.text: \(self?.locationLabel.text)")
                        
                        self?.tableView.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    func getHKData() {
        
        let weatherReq = WeatherManager(latitude: 59.91116, longitude: 10.74481)
        Items.sharedInstance.myLocationLat = 59.91116
        Items.sharedInstance.myLocationLon = 10.74481
        weatherReq.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.presentAlert(message: "Nettverkskall feilet. Kunne ikke hente data for denne posisjonen.")
            case .success(let weatherProps):
                self?.listOfWeather.append(contentsOf: weatherProps)
                Items.sharedInstance.sharedArray.removeAll()
                Items.sharedInstance.sharedArray.append(contentsOf: weatherProps)
                self?.sharedArrayList.removeAll()
                self?.sharedArrayList.append(contentsOf: weatherProps)
                DispatchQueue.main.async {
                    self?.locationLabel.text = "Din lokasjon: HK"
                    self?.tableView.reloadData()
                    Items.sharedInstance.imageName = weatherProps[1].imageString
                    
                }
            }
        }
        
    }
    
    func getData() {
        if ((LocationManager.shared.currentLocation?.location.coordinate) != nil) {
            print("getData: getCurrentLocationData")
            LocationManager.shared.startLocationUpdater { () -> ()? in
                self.showLocation()
            }
            getCurrentLocationData()
        } else {
            print("getData: getHKData")
            getHKData()
            LocationManager.shared.startLocationUpdater { () -> ()? in
                self.showLocation()
            }
            
        }
        
    }
    
    
    
    
}

//MARK: - UITableViewDataSource, WeatherManagerDelegate
extension ForecastController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Items.sharedInstance.sharedArray.count")
        print(Items.sharedInstance.sharedArray.count)
        return Items.sharedInstance.sharedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        let weatherModelList = Items.sharedInstance.sharedArray[indexPath.row]
        
        let titles = ["NÅ", "NESTE TIME", "NESTE 6 TIMER", "NESTE 12 TIMER"]
        let tempWeather = ["Temperatur:", "Vær:", "Vær:", "Vær:"]
        
        let rain = weatherModelList.rain
        let summary = weatherModelList.summary
        let temperature = weatherModelList.temperature
        let rainUnits = weatherModelList.rainUnits
        let tempUnits = weatherModelList.tempUnits
        
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

//MARK: - Alert Handler
extension ForecastController {
    func presentAlert(message: String) {
        DispatchQueue.main.async {
            let alertToUser = alertService.alertUser(message: message)
            
            self.present(alertToUser, animated: true)
        }
        
        return
    }
}








