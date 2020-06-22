//
//  HomeViewController.swift
//  RebelFoods
//
//  Created by Soumya Jain on 22/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: HomeViewModel!
    private let playerViewController = AVPlayerViewController()
    private var player = AVPlayer()
    
    private var playerViewModel: HomeTableCellViewModel!
    private var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitialData()
        self.configureViews()
        self.viewModel.getVideosAndCategories()
    }

    private func setupInitialData() {
        self.viewModel = HomeViewModel()
        self.observeEvents()
    }
    
    private func observeEvents() {
        self.viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureViews() {
        self.configureTableView()
    }
    
    private func configureTableView() {
        self.register(table: tableView)
        HomeTableCell.registerWithTable(tableView)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let (headerString, nodeArray) = self.viewModel.getMediaModel(on: indexPath.section)
            else { return UITableViewCell() }
        
        guard let cell = HomeTableCell.getDequeuedCell(for: tableView, indexPath: indexPath)
            as? HomeTableCell else { return UITableViewCell() }
        
        cell.configureCell(headerString: headerString,node: nodeArray, index: indexPath.section)
        cell.delegate = self
        return cell
    }
    
}

extension HomeViewController: HomeTableCellDelegate {
    func gotoVideoPlayerScreen(viewModel: HomeTableCellViewModel, selectedIndex: Int) {
        guard let videoURL = URL(string: viewModel.nodeArray[selectedIndex].getImageURL()) else {return}
        self.playerViewModel = viewModel
        self.selectedIndex = selectedIndex
        self.player = AVPlayer(url: videoURL)
        self.playerViewController.player = player
        
        present(playerViewController, animated: true) {
            var positions = [Int]()
            for (idx, recognizer) in (self.playerViewController.view.subviews[0].gestureRecognizers?.enumerated())! {
                if recognizer is UIPinchGestureRecognizer || recognizer is UIPanGestureRecognizer {
                    positions.append(idx)
                }
            }
            for index in 0..<positions.count {
                self.playerViewController.view.subviews[0].gestureRecognizers?.remove(at: positions[positions.count-index-1])
            }
            self.addGestures()
            self.player.play()
        }
    }
    
    @objc func swipeRight(gesture: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func swipeDown(gesture: UIGestureRecognizer) {
        guard selectedIndex+1 < self.playerViewModel.nodeArray.count else { return }
        selectedIndex += 1
        guard let videoURL = URL(string: self.playerViewModel.nodeArray[selectedIndex].getImageURL()) else {return}
        self.playVideo(url: videoURL)
    }
    
    @objc func swipeUp(gesture: UIGestureRecognizer) {
        guard selectedIndex-1 >= 0 else { return }
        selectedIndex -= 1
        guard let videoURL = URL(string: self.playerViewModel.nodeArray[selectedIndex].getImageURL()) else {return}
        self.playVideo(url: videoURL)
    }
    
    private func playVideo(url: URL) {
        self.player.pause()
        self.player = AVPlayer(url: url)
        self.playerViewController.player = self.player
        self.player.play()
    }
    
    private func addGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        swipeRight.direction = .right
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDown))
        swipeUp.direction = .up
        self.playerViewController.view.subviews[0].addGestureRecognizer(swipeRight)
        self.playerViewController.view.subviews[0].addGestureRecognizer(swipeDown)
        self.playerViewController.view.subviews[0].addGestureRecognizer(swipeUp)
    }
}
