//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by Soumya Jain on 22/06/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {

    var selectedIndex: Int = 0
    var nodes = [Node]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupPlayer()
    }
    
    private func setupPlayer() {
        guard let videoURL = URL(string: nodes[selectedIndex].getImageURL()) else {return}
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.addChild(playerViewController)
        player.play()
    }
    
    class func getController(selectedIndex: Int, nodes: [Node]) -> VideoPlayerViewController? {
        guard let vc = UIViewController.initalizeMyViewController(identifier: .videoPlayer, storyboard: .main)
            as? VideoPlayerViewController else { return nil }
        vc.selectedIndex = selectedIndex
        vc.nodes = nodes
        return vc
    }
    
}
