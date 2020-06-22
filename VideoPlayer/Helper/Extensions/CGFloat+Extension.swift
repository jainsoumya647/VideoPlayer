//
//  CGFloat+Extension.swift
//  BookMyShow
//
//  Created by Soumya Jain on 18/04/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

extension CGFloat {

    func configureAccordingToScreen() -> CGFloat {
        return self*UIScreen.main.bounds.width/414
    }

}
