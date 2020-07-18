//
//  ImageLoader.swift
//  MyGlamm
//
//  Created by Soumya Jain on 28/03/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit
import Combine
import AVFoundation

final class ImageLoader {
    static let shared = ImageLoader()

    let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 8
        return queue
    }()

    init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    @available(iOS 13.0, *)
    func loadThumbnailImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        
        return Just(url)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                self.cache[url] = thumbImage
                return Just(thumbImage)
                    .eraseToAnyPublisher()
            } catch {
                print(error)
                return Just(nil)
                    .eraseToAnyPublisher()
            }
        })
        .subscribe(on: backgroundQueue)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
 
}
