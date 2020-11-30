//
//  HomeForecastController.swift
//  Exam
//
//  
//

import UIKit
import CoreData

class HomeForecastController: UIViewController {
    
    var savedData = [Entity]()
    
    var viewDidAppearCounter: Int = 0
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var descLabelOne: UILabel!
    
    
    @IBOutlet weak var descLabelTwo: UILabel!
    
    let date = Date()
    let dateFormatter = DateFormatter()
    
    var tappedOnce: Bool = false
    var tappedTwice: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.startLocationUpdater { () -> ()? in
            self.showLocation()
        }
        getCurrentLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTriggered(_:)))
        
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func tapTriggered(_ gesture: UITapGestureRecognizer) {
        print("tapped!")
        if tappedOnce == false {
        rotationAnimation()
        } else if (tappedOnce == true) {
            scaleAnimation()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        getCurrentLocation()

    }
}

extension HomeForecastController {
    func showLocation() {
        print("before if let currentLocation")
        if let currentLocation = LocationManager.shared.currentLocation{
            
            let coordinate = currentLocation.location.coordinate
            
            print("showLocation - Latitude: \(coordinate.latitude)")
            
            print("showLocation - Longitude: \(coordinate.longitude)")
            
        }
    }
}

extension HomeForecastController {
    
    fileprivate func getCurrentLocation() {
        //        print("utenfor if let currentLocation")
        if let currentLocation = LocationManager.shared.currentLocation{
            //            print("inne i if let currentLocation")
            
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
                    self?.presentAlert(message: "Nettverkskall feilet. Sjekk at du er koblet til internett, eller restart appen")
                    
                case .success(let weatherProps):
                    DispatchQueue.main.async {
                        
                        self?.dateFormatter.timeZone = .current
                        //        self.dateFormatter.dateStyle = .full
                        self?.dateFormatter.locale = .current
                        self?.dateFormatter.dateFormat = "EEEE"
                        
                        
                        let entity = Entity(context: Persistance.context)
                        entity.day = self?.dateFormatter.string(from: self!.date)
                        
                        entity.image = self?.isItRaining(data: weatherProps[3].imageString) ?? "error"
                        
                        entity.descriptionOne = self?.setLabelOne(data: self?.isItRaining(data: weatherProps[3].imageString) ?? "error1")
                        
                        entity.descriptionTwo = self?.setLabelTwo(data: self?.isItRaining(data: weatherProps[3].imageString) ?? "error2")
                        
                        Persistance.saveContext()
                        self?.savedData.append(entity)
                        
                        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
                        
                        do {
                            let savedData = try Persistance.context.fetch(fetchRequest)
                            self?.savedData = savedData
                            
                            self?.dayLabel.text = self?.savedData[0].day
                            //                            print("self.savedData[0].day")
                            //                            print(self?.savedData[0].day as Any)
                            //
                            self?.descLabelOne.text = self?.savedData[0].descriptionOne
                            //                            print("self.savedData[0].descriptionOne")
                            //                            print(self?.savedData[0].descriptionOne as Any)
                            //
                            self?.descLabelTwo.text = self?.savedData[0].descriptionTwo
                            //                            print("self.savedData[0].descriptionTwo")
                            //                            print(self?.savedData[0].descriptionTwo ?? "error")
                            //
                            self?.imageView.image = UIImage(named: self?.savedData[0].image ?? "error")
                            //                            print("self.savedData[0].day")
                            //                            print(self?.savedData[0].image ?? "error")
                            //
                        } catch {
                            print("error fetching saved data")
                            self?.presentAlert(message: "Det skjedde en feil under innhenting av lagret data")
                        }
                        
                        Items.sharedInstance.imageName = weatherProps[1].imageString
                        
                    }
                }
            }
        } else {
            
            self.imageView.image = UIImage(named: "gi_tilgang")
            
            // kind of a workaround since location will not update after giving access to position
            self.descLabelOne.text = "Gitt tilgang? Gå til"
            self.descLabelTwo.text = "neste side og tilbake"
        }
    }
}


//MARK: - Alert Handler
extension HomeForecastController {
    func presentAlert(message: String) {
        DispatchQueue.main.async {
            let alertToUser = alertService.alertUser(message: message)
            
            self.present(alertToUser, animated: true)
        }
        
        return
    }
}

//MARK: - Check For Rain
extension HomeForecastController {
    
    func isItRaining(data: String) -> String  {
        // cases from imageString in WeatherModel:
        switch data {
        case   "heavy_rain_thunder", "rain_thunder", "heavy_rain", "light_rain", " rain_weather_thunder", " rain", "some_rain_thunder", "rain_weather":
            print("rain")
            return "paraply"
        default:
            print("no rain")
            return "lukket_paraply"
        }
    }
    
    func setLabelOne (data: String) -> String {
        if(data == "paraply") {
            return "I dag blir det regn,"
            
        } else {
            return "Ingen regn i dag,"
        }
    }
    
    func setLabelTwo(data: String) -> String {
        
        if(data == "paraply") {
            return "så ta med paraply!"
            
        } else {
            return "så ingen paraply :)"
        }
        
    }
    
}

//MARK: - Animations
extension HomeForecastController {
    
    func rotationAnimation() {
        print("rotationAnimation")
        tappedOnce = true
        UIView.animate(withDuration: 3, delay: 0.0, options: .autoreverse ,animations: {
            self.imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
            
            self.imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi * 2)))
        })
    }
    
    func scaleAnimation() {
        print("scaledAnimation!")
        // resetting
        tappedOnce = false
        
        UIView.animateKeyframes(withDuration: 3, delay: 0.0, options: .autoreverse, animations: {
            
            self.imageView.transform = CGAffineTransform(scaleX: 3, y: 3)
        }) { finished in
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}


