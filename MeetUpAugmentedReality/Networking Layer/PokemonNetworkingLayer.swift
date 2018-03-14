//
//  PokemonNetworkingLayer.swift
//  MeetUpAugmentedReality
//
//  Created by Matthew Harrilal on 3/13/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class PokemonModelNetworkingLayer {
    let session = URLSession.shared
    
    func getPokemonImage(completionHandler: @escaping(Data) -> Void) {
        let path = "https://pokeapi.co/api/v2/pokemon-form/1/"
        let getRequest = URLRequest(url: URL(string: path)!)
        
        session.dataTask(with: getRequest) { (data
            , response, error) in
            completionHandler(data!)
        }.resume()
    }
}
