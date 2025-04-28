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
    var galaxyTexts: [String]
    
    init(id: UUID, title: String, galaxyImageName: String, galaxyTexts: [String] = []) {
        self.id = id
        self.title = title
        self.galaxyImageName = galaxyImageName
        self.galaxyTexts = galaxyTexts
    }
}
