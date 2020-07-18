//
//  HomeCollectionCell.swift
//  RebelFoods
//
//  Created by Soumya Jain on 22/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit
import Combine

@available(iOS 13.0, *)
class HomeCollectionCell: ReusableCollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var animator: UIViewPropertyAnimator?
    private var cancellable: AnyCancellable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    private func setupCell() {
        self.imageView.setCornerRadius()
    }

    override func prepareForReuse() {
        print("prepareForReuse")
        super.prepareForReuse()
        self.imageView.image = nil
        self.imageView.alpha = 0.0
        self.animator?.stopAnimation(true)
        self.cancellable?.cancel()
    }
    
    func configureCell(node: Node) {
        self.cancellable = self.loadImage(for: node.getImageURL()).sink { (image) in
            self.showImage(image: image)
        }
    }
    
    private func showImage(image: UIImage?) {
        print("showImage")
        self.imageView.alpha = 0.0
        self.animator?.stopAnimation(false)
        self.imageView.image = image
        self.imageView.alpha = 1.0
    }
    
    private func loadImage(for movieURL: String) -> AnyPublisher<UIImage?, Never> {
        return Just(movieURL)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let url = URL(string: movieURL)!
            return ImageLoader.shared.loadThumbnailImage(from: url)
        })
        .eraseToAnyPublisher()
    }
}
