//
//  Results.swift
//  RebelFoods
//
//  Created by Soumya Jain on 22/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

struct Media: Codable {
    var title: String
    var nodes: [Node]
    
}

struct Node: Codable {
    var video: Video
    
    func getImageURL() -> String {
        return video.encodeUrl
    }
}

struct Video: Codable {
    var encodeUrl: String
}
