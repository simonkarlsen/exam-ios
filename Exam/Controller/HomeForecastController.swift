//
//  HomeForecastController.swift
//  Exam
//
//  Created by Simon Bachmann Karlsen on 29/11/2020.
//

import UIKit

class HomeForecastController: UIViewController {
    
    
    
    @IBOutlet weak var dayLabel: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var descLabelOne: UILabel!
    
    
    @IBOutlet weak var descLabelTwo: UILabel!
    
    let date = Date()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.startLocationUpdater { () -> ()? in
            self.showLocation()
        }
        
        
        self.dateFormatter.timeZone = .current
//        self.dateFormatter.dateStyle = .full
        self.dateFormatter.locale = .current
        self.dateFormatter.dateFormat = "EEEE"
        
        dayLabel.text = dateFormatter.string(from: date)
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
