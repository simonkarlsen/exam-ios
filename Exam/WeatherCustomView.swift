//
//  WeatherCustomView.swift
//  Exam
//
//  
//

import UIKit

class WeatherCustomView: UIView {

    
    @IBOutlet var customView: UIView!
    
    
    @IBOutlet weak var latLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let _ = loadViewFromNib()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "WeatherCustomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        addSubview(view)
        return view
    }
    
    func setLabel(_ string: String) {
        latLabel.text = string
    }
}


