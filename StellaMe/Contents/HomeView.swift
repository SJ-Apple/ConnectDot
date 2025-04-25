//
//  HomeView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/25/25.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - settingview에서 인바이어먼트 베경화면 받아옴
struct HomeView: View {
    @Environment(\.modelContext) private var HomeModelContext
    @Query var StarMemoryes: [StarModel] // 별 저장소 이용
    @Query var GalaxyMemoryes: [GalaxyModel] // 별자리 저장소 이용
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("testHomeviewText")
            }
        }
    }
}

// MARK: - 별자리를 누르면 GalxyView로 이동하도록 네비게이션링크 생성

// MARK: - 별을 누르면 StarDetailView로 이동하도록 네비게이션링크 생성

// MARK: - 로켓을 누르면 MakeSelectView로 네비게이션링크 생성

// MARK: - 공구함 누르면 settingview로 넘어가도록 네비게이션링크 생성.

#Preview {
    HomeView()
}
