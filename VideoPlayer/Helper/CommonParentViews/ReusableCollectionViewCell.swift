//
//  ReusableCollectionViewCell.swift
//  VideoPlayer
//
//  Created by Soumya Jain on 21/06/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class ReusableCollectionViewCell: UICollectionViewCell {

    /// Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }

    /// Registers the Nib with the provided table
    static func registerWithCollection(_ collection: UICollectionView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier, bundle: bundle)
        collection.register(nib, forCellWithReuseIdentifier: self.reuseIdentifier)
    }

    static func getDequeuedCell(for collection: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        return collection.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
    }

}
