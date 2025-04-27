//
//  StarView.swift
//  StellaMe
//
//  Created by Hwi on 4/26/25.
//
// 클릭할 수 있는 객체로의 Star
import SwiftUI
import SwiftData

struct StarView: View {
    let star: StarModel
    @EnvironmentObject var backgroundSettings: BackgroundSettings
    var body: some View {
        NavigationLink(destination: StarDetailView(star: star).environmentObject(BackgroundSettings())) {
            VStack {
                Image("Star1")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())

                Text(star.starText)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            .padding()
        }
        .buttonStyle(.plain)
    }
}

// 프리뷰
#Preview {
    StarView(star: StarModel(starID: UUID(), starText: "", date: Date()))
}
