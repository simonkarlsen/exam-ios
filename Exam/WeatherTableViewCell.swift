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
        
    }	
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
  
    
    
    
}
