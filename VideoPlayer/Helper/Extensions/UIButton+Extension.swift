//
//  UIButton+Extension.swift
//  BookMyShow
//
//  Created by Soumya Jain on 19/04/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

extension UIButton {
    
    func configureThemeButton() {
        self.backgroundColor = .themeBlueColor
        self.setTitleColor(.white, for: .normal)
        self.setCornerRadius()
    }
    
}
