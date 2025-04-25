//
//  StarModel.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/25/25.
//

import Foundation
import SwiftData

// MARK: - 텍스트 선언
@Model
class StarModel {
    var starID: UUID = UUID()
    var starText: String
    // 날짜 값도 넣고
    // 은하 id 생성되있는거 참조
    init(starID: UUID, starText: String) {
        self.starID = starID
        self.starText = starText
    }
}
