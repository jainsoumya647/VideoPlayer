//
//  UIView+Extension.swift
//  BookMyShow
//
//  Created by Soumya Jain on 19/04/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

extension UIView {
    
    func setCornerRadius(radius: CGFloat = 5) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
}
