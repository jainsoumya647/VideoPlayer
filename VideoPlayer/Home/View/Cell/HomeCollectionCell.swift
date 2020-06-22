//
//  HomeCollectionCell.swift
//  RebelFoods
//
//  Created by Soumya Jain on 22/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit
import Combine

class HomeCollectionCell: ReusableCollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    private var animator: UIViewPropertyAnimator?
//    private var cancellable: AnyCancellable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    private func setupCell() {
        self.imageView.setCornerRadius()
    }

//    override func prepareForReuse() {
//        print("prepareForReuse")
//        super.prepareForReuse()
//        self.imageView.image = nil
//        self.imageView.alpha = 0.0
//        self.animator?.stopAnimation(true)
//        self.cancellable?.cancel()
//    }
    
    func configureCell(node: Node) {
        self.loadImage(for: node.getImageURL())
    }
    
//    private func showImage(image: UIImage?) {
//        print("showImage")
//        self.imageView.alpha = 0.0
//        animator?.stopAnimation(false)
//        self.imageView.image = image
//        self.imageView.alpha = 1.0
//    }
    
    private func loadImage(for movieURL: String) {
        guard let url = URL(string: movieURL) else { return }
        return ImageLoader.shared.loadThumbnailImage(from: url) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
