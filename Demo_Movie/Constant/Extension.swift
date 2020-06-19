//
//  Extension.swift
//  Demo-Vimal
//
//  Created by Vimal Bosamiya on 06/06/20.
//  Copyright © 2020 Vimal Bosamiya. All rights reserved.
//

import UIKit

//MARK:- Alert
extension UIViewController {
    
    func showAlert(title: String? = nil, message:String, cancelButtonTitle: String = "OK", handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        var strTitle: String? = title
        var strMessage: String? = message
        
        if strTitle == nil {
            strTitle = message
            strMessage = nil
        }
        
        let alert = UIAlertController(title: strTitle,
                                                                    message: strMessage,
                                                                    preferredStyle: .alert)
        
        let action = UIAlertAction(title: cancelButtonTitle, style: .default, handler: handler)
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            alert.overrideUserInterfaceStyle = .light
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
