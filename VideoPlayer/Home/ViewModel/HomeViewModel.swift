//
//  HomeViewModel.swift
//  RebelFoods
//
//  Created by Soumya Jain on 22/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation
class HomeViewModel {
    
    var reloadData: (() -> Void)?
    private var mediaArray: [Media]? {
        didSet {
            self.reloadData?()
        }
    }
    
    func getVideosAndCategories() {
        APIServiceLayer().getRepositories { (media) in
            self.mediaArray = media
        }
    }
    
    func getNumberOfSections() -> Int {
        return self.mediaArray?.count ?? 0
    }
    
    func getMediaModel(on index: Int) -> (String, [Node])? {
        guard let media = self.mediaArray else {
            return nil
        }
        
        return (media[index].title, media[index].nodes)
    }
}
