//
//  UIImageView+Extension.swift
//  VideoPlayer
//
//  Created by Soumya Jain on 21/06/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from urlString: String) {
        print("Download Started")
        DispatchQueue.main.async() {
            self.image = Image.placeholder
        }
        guard let url = URL(string: urlString) else { return }
        self.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
