//
//  APIServiceLayer.swift
//  VideoPlayer
//
//  Created by Soumya Jain on 21/06/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import Foundation
struct APIServiceLayer {
    
    typealias RepositoryCompletionBlock = (_ model: [Media]) -> Void

    func getRepositories(completion: @escaping RepositoryCompletionBlock) {

        let url = Bundle.main.url(forResource: "assignment", withExtension: "json")
                
        guard let jsonData = url else{return}
        guard let data = try? Data(contentsOf: jsonData) else { return }
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode([Media].self, from: data) else { return }
        completion(response)
    }
}
