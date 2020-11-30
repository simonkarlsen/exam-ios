//
//  WeatherCustomView.swift
//  Exam
//
//
//

import UIKit


protocol CustomDelegate {
    func giveDataToCustomView(latitudeLabel: String, longitudeLabel: String, imageName: String)
}


class WeatherCustomView: UIView {
    
    
    //    @IBOutlet var customView: UIView!
    //
    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var lonLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var customDelegate: CustomDelegate!
    
    override func awakeFromNib() {
//                imageView.layer.cornerRadius = 15
//                lonLabel.layer.cornerRadius = 15
//                latLabel.layer.cornerRadius = 15
//
//                imageView.layer.masksToBounds = true
//                lonLabel.layer.masksToBounds = true
//                latLabel.layer.masksToBounds = true
    }
    
    func giveInfo (latitudeInfo: String, longitudeInfo: String, imageInfo: String) {
        
        customDelegate.self.giveDataToCustomView(latitudeLabel: latitudeInfo, longitudeLabel: longitudeInfo, imageName: imageInfo)
        
    }
    
    func xibInit(imageName: String, lonInfo: String, latInfo: String) {
        imageView.image = UIImage(named: imageName)
        lonLabel.text = lonInfo
        latLabel.text = latInfo

        
        print("imageName: \(imageName), lonInfo: \(lonInfo), latInfo: \(latInfo)")
    }
    
    
}





