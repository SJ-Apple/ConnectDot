//
//  StarDetailView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/25/25.
//

import SwiftUI
import SwiftData

struct StarDetailView: View {
    @EnvironmentObject var backgroundSettings: BackgroundSettings
    let star: StarModel

    var body: some View {
        ZStack {
            // 배경 이미지 + 오버레이
            Image(backgroundSettings.currentBackgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.5))

            VStack {
                Spacer()
                    .frame(height: 250) // 상단 여백

                // 별 아이콘
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.yellow)
                    .shadow(radius: 10)

                Spacer()
                    .frame(height: 20)

                // 별 제목
                Text(star.starText)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)

                Spacer()
                    .frame(height: 20)

                // 생성일자 표시
                VStack(spacing: 8) {
                    Text("생성 날짜")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))

                    Text(star.date.formatted(date: .long, time: .shortened))
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 5)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("별 세부정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StarModel.self, configurations: config)

    let context = container.mainContext
    let sampleStar = StarModel(starID: UUID(), starText: "미리보기 별", date: Date())
    context.insert(sampleStar)

    return NavigationStack {
        StarDetailView(star: sampleStar)
            .modelContainer(container)
            .environmentObject(BackgroundSettings())
    }
}
