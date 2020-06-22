//
//  Constants.swift
//  BookMyShow
//
//  Created by Soumya Jain on 18/04/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

struct Constants {
    static let perPage = 10
}

enum Storyboard: String {
    case main = "Main"
}

enum Controller: String {
    case videoPlayer = "VideoPlayerViewController"
}

struct Height {
    static func safeTopStatusArea() -> CGFloat {
        return UIApplication.shared.topSafeArea
    }
    static let naviagtionHeight: CGFloat = 50 + Height.safeTopStatusArea()
    static let footerHeight:CGFloat = 40
    static let headerHeight:CGFloat = 30 //+ Height.safeTopStatusArea()
    static let collectionHeight:CGFloat = 100
    static let estimatedHeight:CGFloat = 200
    static let padding:CGFloat = 20
}

struct FontSize {
    static var smaller: CGFloat = FontSize.getCustomSizeOf(font: 10)
    static var small: CGFloat = FontSize.getCustomSizeOf(font: 12)
    static var regular: CGFloat = FontSize.getCustomSizeOf(font: 14)
    static var semiMedium: CGFloat = FontSize.getCustomSizeOf(font: 16)
    static var medium: CGFloat = FontSize.getCustomSizeOf(font: 18)
    static var larger: CGFloat = FontSize.getCustomSizeOf(font: 24)
    static var largest: CGFloat = FontSize.getCustomSizeOf(font: 30)
    static private func getCustomSizeOf(font: CGFloat) -> CGFloat {
        return font.configureAccordingToScreen()
    }
}

enum NibName: String {
    case navigationHeader = "NavigationHeader"
}

struct ErrorMessage {
    static let somethingWrong = "Something went wrong while executing."
    static let noInternetConnection = "No Internet!! Please check your connection and try again."
}

struct Image {
    static let placeholder = UIImage(named:"Avatar")
    static let back = UIImage(named:"back")
}

enum ResponseError: Error {
    case customError(_ errorMessage: String)
}

extension ResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .customError(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
