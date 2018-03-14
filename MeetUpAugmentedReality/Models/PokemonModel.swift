//
//  PokemonModel.swift
//  MeetUpAugmentedReality
//
//  Created by Matthew Harrilal on 3/13/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon {
    var frontDefault: String
    var isBattleOnly: Bool
    init(frontDefault: String, isBattleOnly: Bool) {
        self.frontDefault = frontDefault
        self.isBattleOnly = isBattleOnly
    }
}

extension Pokemon: Decodable {
    enum FirstLevelKeys: String, CodingKey {
        case isBattleOnly =  "is_battle_only"
        case sprites
    }
    
    enum SecondLevelKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FirstLevelKeys.self)
        let isBattleOnly = try container.decode(Bool.self, forKey: .isBattleOnly)
        let innerContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .sprites)
        let frontDefault = try innerContainer.decode(String.self, forKey: .frontDefault)
        self.init(frontDefault: frontDefault, isBattleOnly: isBattleOnly)
    }
}
