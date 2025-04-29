//
//  GalaxyDetailView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/24/25.

import SwiftUI
import SwiftData

struct GalaxyDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var backgroundSettings: BackgroundSettings
    let galaxyModel: GalaxyModel

    var body: some View {
        ZStack {
            // 배경 이미지 + 오버레이
            Image(backgroundSettings.currentBackgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.5))

            VStack {
                Spacer().frame(height: 80) // 상단 여백

                // 갤럭시 이미지 (위치 고정)
                Image(galaxyModel.galaxyImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .shadow(radius: 10)

                Spacer().frame(height: 20)

                // 별자리 이름 (타이틀)
                Text(galaxyModel.title)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .shadow(radius: 5)

                Spacer().frame(height: 20)

                // 별자리 설명 리스트
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {

                        ForEach(Array(galaxyModel.galaxyStars.enumerated()), id: \.element.id) { index, galaxyStar in
                            if let linkedStar = galaxyStar.linkedStar {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(linkedStar.starText)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 10)
                                    
                                    // 마지막 줄이 아닐 때만 Divider
                                    if index != galaxyModel.galaxyStars.count - 1 {
                                        Divider()
                                            .background(Color.white.opacity(0.3))
                                    }
                                }
                            }
                        }

                        
                    } //: VStack
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)
                }
                .navigationTitle(galaxyModel.title)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    GalaxyDetailView(
        galaxyModel: GalaxyModel(
            id: UUID(),
            title: "파운데이션 마지막날",
            galaxyImageName: "yellow",
            galaxyStars: [GalaxyStarModel(id: UUID(), linkedStar: StarModel(starID: UUID(), starText: "헛둘", date: Date())), GalaxyStarModel(id: UUID(), linkedStar: StarModel(starID: UUID(), starText: "ddd", date: Date()))]
        )
    )
    .environmentObject(BackgroundSettings())
}
