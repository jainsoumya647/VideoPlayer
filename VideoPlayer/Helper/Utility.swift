//
//  Utility.swift
//  BookMyShow
//
//  Created by Soumya Jain on 18/04/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

struct Utility {

    static let imageCache = NSCache<NSString, UIImage>()
    
    static func printErrorAndShowAlert(error: Error?) {
        print(error?.localizedDescription ?? ErrorMessage.somethingWrong)
        self.showOkAlert(message: error?.localizedDescription ?? ErrorMessage.somethingWrong)
    }

    static func showOkAlert(with title: String? = nil, message: String) {
        DispatchQueue.main.async {
            UIApplication.getTopViewController()?.presentOkAlertWith(title: title, message: message)
        }
    }    
}
