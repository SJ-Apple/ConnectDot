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
    @State private var showDeleteAlert = false
    @State private var selectedStar: GalaxyStarModel?
    @State private var showToast = false
    
    let galaxyModel: GalaxyModel

    var body: some View {
        ZStack {
            // 배경
            Image(backgroundSettings.currentBackgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.5))
            
            VStack {
                Spacer().frame(height: 80)

                // 갤럭시 이미지
                Image(galaxyModel.galaxyImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .shadow(radius: 10)

                Spacer().frame(height: 20)

                // 타이틀
                Text(galaxyModel.title)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .shadow(radius: 5)

                Spacer().frame(height: 20)

                // 스크롤 가능한 별 리스트
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(galaxyModel.galaxyStars.enumerated()), id: \.element.id) { index, galaxyStar in
                            if let linkedStar = galaxyStar.linkedStar {
                                HStack {
                                    Text(linkedStar.starText)
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(linkedStar.date, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .contentShape(Rectangle())
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        selectedStar = galaxyStar
                                        showDeleteAlert = true
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }

                                // 마지막이 아니면 Divider
                                if index != galaxyModel.galaxyStars.count - 1 {
                                    Divider()
                                        .background(Color.white.opacity(0.3))
                                }
                            }
                        }
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)
                }

                Spacer()
            }
            .padding()

            // 삭제 토스트
            if showToast {
                VStack {
                    Spacer()
                    Text("삭제되었습니다")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.bottom, 30)
                }
                .transition(.opacity)
            }
        }
        .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert, actions: {
            Button("삭제", role: .destructive) {
                if let starToDelete = selectedStar {
                    if let index = galaxyModel.galaxyStars.firstIndex(where: { $0.id == starToDelete.id }) {
                        galaxyModel.galaxyStars.remove(at: index)
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showToast = false
                        }
                    }
                }
            }
            Button("취소", role: .cancel) { }
        })
        .navigationTitle(galaxyModel.title)
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
