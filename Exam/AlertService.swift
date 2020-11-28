//
//  AlertService.swift
//  Exam
//
//  Created by Simon Bachmann Karlsen on 28/11/2020.
//

import UIKit

class AlertService {
    
    func alertUser(message: String) -> UIAlertController {
        let alertToUser = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertToUser.addAction(alertAction)
        
        return alertToUser
    }
}

