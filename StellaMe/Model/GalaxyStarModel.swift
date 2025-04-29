//
//  GalaxyStarModel.swift
//  StellaMe
//
//  Created by Hwi on 4/28/25.
//


import SwiftData
import Foundation

@Model
class GalaxyStarModel {
    @Attribute(.unique) var id: UUID
    var linkedStar: StarModel?
    
    init(id: UUID, linkedStar: StarModel? = nil) {
        self.id = id
        self.linkedStar = linkedStar    }
}
