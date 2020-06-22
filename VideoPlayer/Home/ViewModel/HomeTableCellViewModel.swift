//
//  HomeTableCellViewModel.swift
//  RebelFoods
//
//  Created by Soumya Jain on 22/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation

class HomeTableCellViewModel {
    
    var nodeArray: [Node]
    
    init(node: [Node]) {
        self.nodeArray = node
    }
    
    func getNumberOfItems() -> Int {
        return self.nodeArray.count
    }
    
    func getNode(on index: Int) -> Node {
        return self.nodeArray[index]
    }
}
