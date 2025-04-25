//
//  GalaxyModel.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/25/25.
//

import Foundation
import SwiftData

// MARK: - 텍스트, 별자리 선택 이미지 저장할 수 있도록.
@Model
class GalaxyModel {
    var GalaxyID: UUID = UUID()
    var GalaxyTitle: String
    var GalaxyImage: String
    var GalaxyStarList: [String] = []
    
    init(GalaxyID: UUID, GalaxyTitle: String, GalaxyImage: String) {
        self.GalaxyID = GalaxyID
        self.GalaxyTitle = GalaxyTitle
        self.GalaxyImage = GalaxyImage
    }
}

enum GalaxyShape: String, CaseIterable {
    case firstStar
    case secondStar
    case thirdStar
    case fourthStar
    case fifthStar
    
    var imageName: String {
        switch self {
        case .firstStar: return "firstStar"
        case .secondStar: return "secondStar"
        case .thirdStar: return "thirdStar"
        case .fourthStar: return "fourthStar"
        case .fifthStar: return "fifthStar"
        }
    }
}
