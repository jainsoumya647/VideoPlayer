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

    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 8
        return queue
    }()

    init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }

    @available(iOS 13.0, *)
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .print("Image loading \(url):")
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func loadThumbnailImage(from url: URL, completion: @escaping ((_ image: UIImage?) -> ())) {
        
        DispatchQueue.global().async {
            if let image = self.cache[url] {
                completion(image)
                return
            }
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                self.cache[url] = thumbImage
                completion(thumbImage)
                return
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    @available(iOS 13.0, *)
    func loadThumbnailImage2(from url: URL, completion: @escaping ((_ image: UIImage?) -> ())) {
        
        URLSession.shared.dataTaskPublisher(for: url)
        .map { (data, response) -> UIImage? in return UIImage(data: data) }
        .catch { error in return Just(nil) }
        .handleEvents(receiveOutput: {[unowned self] image in
            guard let image = image else { return }
            self.cache[url] = image
        })
        .print("Image loading \(url):")
        .subscribe(on: backgroundQueue)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
        
        DispatchQueue.global().async {
            if let image = self.cache[url] {
                completion(image)
                return
            }
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                self.cache[url] = thumbImage
                completion(thumbImage)
                return
            } catch {
                print(error.localizedDescription)
                return
            }
            
        }
    }
}
