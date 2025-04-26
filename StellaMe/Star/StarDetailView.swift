//
//  StarDetailView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/25/25.
//

import SwiftUI
import SwiftData

struct StarDetailView: View {
    // TODO: ContentView에 ModelContainer 삽입하기
    // TODO: HomeView에서 StarMemoryes이용해서 별 뿌려주기
    @EnvironmentObject var backgroundSettings: BackgroundSettings
    let star: StarModel

    var body: some View {
        VStack(spacing: 20) {
            Text("별 내용")
                .font(.headline)
            Text(star.starText)
                .padding()

            Text("생성 날짜")
                .font(.subheadline)
            Text(star.date.formatted(date: .long, time: .shortened))
        }
        .padding()
        .navigationTitle("별 세부정보 뷰")
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
