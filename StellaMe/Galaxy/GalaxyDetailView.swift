////
////  GalaxyDetailView.swift
////  StellaMe
////
////  Created by JaeyoungLee on 4/24/25.
////
//
//import Foundation
//import SwiftUI
//import SwiftData
//
//struct GalaxyDetailView: View {
//    @Environment(\.modelContext) private var modelContext
//    @EnvironmentObject var backgroundSettings: BackgroundSettings
//    let galaxyModel: GalaxyModel
//
//    var body: some View {
//        ZStack {
//            // 배경 이미지 + 블러
//            Image(backgroundSettings.currentBackgroundImage)
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .overlay(Color.black.opacity(0.2))
//
//            VStack {
//                Spacer()
//                    .frame(height: 80) // 최상단 여백
//
//                ZStack {
//                    // Galaxy 이미지
//                    Image(galaxyModel.galaxyImageName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 250, height: 250)
//                        .shadow(radius: 10)
//
//                    VStack(spacing: 8) {
//                        // 타이틀
//                        Text(galaxyModel.title)
//                            .font(.title.bold())
//                            .foregroundColor(.white)
//                            .shadow(radius: 5)
//                            .padding(.top, 160)
//
//                        Spacer()
//                            .frame(height: 30)
//
//                        // 설명 블럭 (텍스트 여러 개를 한 블럭에 합치기)
//                        if !galaxyModel.galaxyTexts.isEmpty {
//                            Text(galaxyModel.galaxyTexts.joined(separator: "\n")) // <- 여러 줄 합치기
//                                .font(.body)
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.center)
//                                .padding(.horizontal, 20)
//                                .padding(.vertical, 16)
//                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
//                                .shadow(radius: 5)
//                        }
//                    }
//                    .offset(y: 120) // Galaxy 이미지 아래 고정
//                }
//
//                Spacer()
//            }
//            .padding()
//        }
//    }
//}
//
//#Preview {
//    GalaxyDetailView(
//        galaxyModel: GalaxyModel(
//            id: UUID(),
//            title: "제발",
//            galaxyImageName: "sampleGalaxyImage", // 예시 이미지 이름
//            galaxyTexts: ["이 별자리는 나의 첫 프로젝트!", "또 다른 메모", "추가 설명"]
//        )
//    )
//    .environmentObject(BackgroundSettings())
//}
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
            // 배경 이미지 + 블러 효과
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
                        ForEach(galaxyModel.galaxyTexts, id: \.self) { text in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(text)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                
                                Divider()
                                    .background(Color.white.opacity(0.3))
                            }
                        }
                    } //: VStack
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)
                }

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
            title: "제발",
            galaxyImageName: "sampleGalaxyImage",
            galaxyTexts: [
                "이 별자리는 나의 첫 프로젝트!",
                "또 다른 메모",
                "추가 설명"
            ]
        )
    )
    .environmentObject(BackgroundSettings())
}
