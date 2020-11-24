//
//  WeatherTableViewCell.swift
//  Exam
//
//  
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherTableViewCell"
    
    var timeSeries = [Timesery]()
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    @IBOutlet var hourTitleLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var weather: UILabel!
    @IBOutlet var rainAmount: UILabel!
    @IBOutlet var rainUnit: UILabel!
    @IBOutlet var temp: UILabel!
    @IBOutlet var tempUnit: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }	

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    public func configure<T: RangeExpression>(hourTitle: [T],labelTitle: [T], tempOrWeather: [T], amountOfRain: [T], units: T) {
        
//        var checkMomentOfTime = hourTitle
//
//        for i in checkMomentOfTime {
//            var momentOfTimeTitle: String {
//                var string: String = checkMomentOfTime[i]
//                if string is Instant {
//                    return "nå"
//                    print("checkMomentOfTime nå: \(checkMomentOfTime)")
//                } else if (checkMomentOfTime[i] is NextHours){
//                    return "Neste time"
//                    print("checkMomentOfTime Neste time: \(checkMomentOfTime)")
//                } else if (checkMomentOfTime[i] is Next6Hours){
//                    return "Neste 6 timer"
//                    print("checkMomentOfTime Neste 6 timer: \(checkMomentOfTime)")
//                } else if (checkMomentOfTime[i] is Next12_Hours){
//                    return "Neste 12 timer"
//                    print("checkMomentOfTime Neste 12 timer: \(checkMomentOfTime)")
//                } else {
//
//                    return checkMomentOfTime as! String
//                }
//            }
//        }
        
        
        
        
//
//        hourTitleLabel.text = momentOfTimeTitle
//        titleLabel.text = labelTitle as? String
//        weatherOrTemp.text = tempOrWeather as? String
//        rainAmount?.text = ("\(amountOfRain) \(units)") as? String
//        if amountOfRain != nil {
//
//            rainAmount?.text = String("\(amountOfRain) mm")
//        } else {
//            rainAmount?.text = "nil"
//        }
//    }
    
}
