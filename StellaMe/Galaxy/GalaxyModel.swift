//
//  GalaxyModel.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/24/25.
//

import Foundation
import SwiftData

// MARK: - 텍스트, 별자리 선택 이미지 저장할 수 있도록.
@Model
class GalaxyModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var galaxyImageName: String
    var galaxyStars: [GalaxyStarModel] = []
    
    init(id: UUID, title: String, galaxyImageName: String, galaxyStars:[GalaxyStarModel] = []) {
        self.id = id
        self.title = title
        self.galaxyImageName = galaxyImageName
        self.galaxyStars = galaxyStars
    }
}
