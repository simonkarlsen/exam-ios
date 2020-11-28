//
//  AlertService.swift
//  Exam
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

