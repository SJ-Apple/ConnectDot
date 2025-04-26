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

    var body: some View {
        NavigationLink(destination: StarDetailView(star: star)) {
            VStack {
                // TODO: 이미지 설정, 디자인 바꾸기
                Image(systemName: "star.fill")
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
        .buttonStyle(.plain) // 기본 스타일 제거
    }
}

// 프리뷰
#Preview {
    StarView(star: StarModel(starID: UUID(), starText: "", date: Date()))
}
