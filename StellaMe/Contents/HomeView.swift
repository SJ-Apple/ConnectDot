//
//  HomeView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/24/25.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - settingview에서 인바이어먼트 베경화면 받아옴
struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var backgroundSettings: BackgroundSettings
    @Query var StarMemoryes: [StarModel] // 별 저장소 이용
    @Query var GalaxyMemoryes: [GalaxyModel] // 별자리 저장소 이용
    
    var body: some View {
        GeometryReader { geometry in
                ZStack {
                    // 배경 이미지
                    Image(backgroundSettings.currentBackgroundImage)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    // 화면 상단 일정 공간에 내가 저장한 갤럭시 띄우는 로직
                    ForEach(GalaxyMemoryes) { galaxyMemory in
                        NavigationLink(destination: GalaxyDetailView(galaxyModel: galaxyMemory)) {
                            Image(galaxyMemory.galaxyImageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .position(x: CGFloat.random(in: 0...(geometry.size.width)),
                                  y: CGFloat.random(in: 0...(geometry.size.height) / 2))
                        
                    } //: Loop
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    // 랜덤 별 배치
                    ForEach(StarMemoryes.sorted(by: {$0.date > $1.date}).prefix(5)) {
                        star in StarView(star: star)
                            .position(
                                x: CGFloat.random(in: 0...(geometry.size.width)),
                                y: CGFloat.random(in: 0...(geometry.size.height) / 2)
                            )
                    }

                    VStack {
                        Spacer()

                        // 새 별 만들러 가기 버튼
                        //TODO: 화면 특정 위치에 고정
                        NavigationLink(destination: MakeAndSelectView().modelContainer(modelContext.container)) {
                            Text("새 별 만들러 가기")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
        

                        
                    

                        // 개발용 버튼 (필요시만 표시)
                        Button {
                            deleteAllGalaxies()
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 200, height: 50)
                                .overlay {
                                    Text("갤럭시 데이터 삭제 (개발용)")
                                        .foregroundColor(.white)
                                }
                        }
                        .padding()
                        
                        // TODO: 화면 특정 위치에 고정 GeoMericReader 사용 도구함 이미지로 변경
                        NavigationLink(destination: SettingView().environmentObject(backgroundSettings)) {
                                Text("배경화면 설정")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                        }.padding()
                      Spacer()

                        
                    }
                    .padding()
                    
                    
                } //: ZStack
            
   
        }.onAppear {
            print("⭐️ 현재 starMemoryes: \(StarMemoryes.map { $0.starText })")
            print("🌌 현재 galaxyMemoryes: \(GalaxyMemoryes.map { $0.title })")
        }
        
    }
    
    
    // 모든 GalaxyModel 삭제 함수
    private func deleteAllGalaxies() {
        for galaxy in GalaxyMemoryes {
            modelContext.delete(galaxy)
        }
        try? modelContext.save()
    }
}



struct HomeViewPreviewWrapper: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .modelContainer(previewContainer)
                .environmentObject(BackgroundSettings())
        }
    }

    var previewContainer: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: StarModel.self, GalaxyModel.self, configurations: config)
        let context = container.mainContext

        let previewStar = StarModel(starID: UUID(), starText: "미리보기 별", date: Date())
        context.insert(previewStar)

        let previewGalaxy = GalaxyModel(id: UUID(), title: "제발", galaxyImageName: "fifthStar", galaxyTexts: ["1번", "2번"])
        context.insert(previewGalaxy)

        try! context.save()
        return container
    }
}

#Preview {
    HomeViewPreviewWrapper()
}
