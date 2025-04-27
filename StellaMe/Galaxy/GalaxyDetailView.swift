//
//  GalaxyDetailView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/24/25.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - TODO -> settingview에서 인바이어먼트 배경화면 데이터 받아오기.
struct GalaxyDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var GalaxyMemory: [GalaxyModel]
    let galaxyModel: GalaxyModel
    
    var body: some View {
        List {
            ForEach(galaxyModel.galaxyTexts, id: \.self) { galaxyText in
                Text(galaxyText)
            }
        }
    }
}

#Preview {
    GalaxyDetailView(
        galaxyModel: GalaxyModel(
            id: UUID(),
            title: "파운데이션 마지막날",
            galaxyImageName: "yellow",
            galaxyTexts: ["헛둘헛둘", "개발 찔끔 했음"]
        )
    )
}
