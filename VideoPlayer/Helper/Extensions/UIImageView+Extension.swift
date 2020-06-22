//
//  UIImageView+Extension.swift
//  VideoPlayer
//
//  Created by Soumya Jain on 21/06/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    func downloadThumbnailImageFromVideoUrl(urlStr: String, completion: @escaping ((_ image: UIImage?)->Void)) {
        guard let url = URL(string: urlStr) else {
            DispatchQueue.main.async() {
                self.image = Image.placeholder
            }
            return
        }
        DispatchQueue.global().async {
            DispatchQueue.main.async() {
                self.image = Image.placeholder
            }
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                DispatchQueue.main.async {
                    self.image = thumbImage
                    completion(thumbImage)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
}
