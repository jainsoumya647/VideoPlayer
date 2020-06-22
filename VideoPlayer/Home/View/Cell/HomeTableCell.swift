//
//  HomeTableCell.swift
//  RebelFoods
//
//  Created by Soumya Jain on 22/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

protocol HomeTableCellDelegate: class {
//    func seeAllAction(viewModel: HomeTableCellViewModel)
    func gotoVideoPlayerScreen(viewModel: HomeTableCellViewModel, selectedIndex: Int)
}

class HomeTableCell: ReusableTableViewCell {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    weak var delegate: HomeTableCellDelegate?
    var viewModel: HomeTableCellViewModel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    func setupCell() {
        collectionView.dataSource = self
        collectionView.delegate = self
        HomeCollectionCell.registerWithCollection(collectionView)
    }
    
    func configureCell(headerString: String, node: [Node], index: Int) {
        self.seeAllButton.tag = index
        self.headerTitleLabel.text = headerString
        self.viewModel = HomeTableCellViewModel(node: node)
        self.collectionView.reloadData()
    }
    
    @IBAction func seeAllAction(_ sender: UIButton) {
//        self.delegate?.seeAllAction(viewModel: self.viewModel)
    }
    
}

extension HomeTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.getNumberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = HomeCollectionCell.getDequeuedCell(for: collectionView, indexPath: indexPath)
            as? HomeCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(node: self.viewModel.getNode(on: indexPath.item))
        return cell
    }
}

extension HomeTableCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionViewHeight.constant-20
        return CGSize(width: height-20, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.gotoVideoPlayerScreen(viewModel: self.viewModel, selectedIndex: indexPath.item)
    }
    
}
