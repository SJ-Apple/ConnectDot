//
//  SettingView.swift
//  StellaMe
//
//  Created by Hwi on 4/24/25.
//

import Foundation
import SwiftUI

// MARK: - TODO -> @인바이어먼트오브젝트로 세팅 뷰 뿌려주기
// MARK: - 배경화면 설정을 위한 Environment 객체

// 기존 Published에서 AppStorage로 변경함
// Why? : 기존 방식인 Published의 경우 메모리 상에서 값이 유지되므로 앱 종료 후 재실행을 하는 경우에 배경 이미지가 기본 값으로 초기화 되는 문제가 있었다. 사용자 설정을 저장하는데 SwiftData는 필요 이상으로 무겁기 때문에 AppStorage를 이용해서 사용자 설정을 저장하였다.

class BackgroundSettings: ObservableObject {
    @AppStorage("currentBackgroundImage") var currentBackgroundImage: String = "DefaultImage"
}

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var backgroundSettings: BackgroundSettings
    @State private var selectedImage: String = ""
    
    // MARK: - 배경화면 이미지 리소스 목록
    private let alternativeBackgroundImage: [String] = [
        // 배경화면 이미지 파일 넣고, 해당 이미지의 이름 넣으시면 됩니다.
        // 현재 이미지는 서로 사이즈가 달라서 수정 필요
        "DefaultImage",
        "Marsbg",
        "Pinkbg"
    ]
    
    // MARK: -  주요 기능
    // 1. TabView를 이용한 페이지 스와이프 기능
    // 2. 하단에 페이지 인디케이터를 통해 현재 페이지 확인 가능, 선택한 배경화면을 여러 View에서 적용 가능
    // https://seons-dev.tistory.com/entry/SwiftUI-TabView (참고 링크)
    
    // MARK: - 필요한 요소
    // 1. Figma상의 Edit버튼 (변경한 배경화면을 적용할 수 있도록 동작)
    // 2. 이미지 에셋 크기 통일
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 배경 전체 검은색
                Color.black.edgesIgnoringSafeArea(.all)
                
                //TabView는 각 이미지 파일 ForEach로 각 Tab(1,2,3)에 할당, Page스타일 적용
                TabView(selection: $selectedImage) {
                    ForEach(alternativeBackgroundImage, id: \.self) { imageName in
                        ZStack {
                            // 이미지 채우는 방식 등 디자인 적 요소는 수정하셔도 됩니다.
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .tag(imageName)
                            
                            // 버튼 추가
                            Button {
                                backgroundSettings.currentBackgroundImage = selectedImage
                                dismiss()
                            } label: {
                                Text("배경화면 변경")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 40)
                            
                        } // ZStack
                        
                    } // ForEach
                    
                } // TabView
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never)) // .always랑 비교해서 마음에 드는 스타일 적용
                
            } // ZStack
            
        } // GeoMetry
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            selectedImage = backgroundSettings.currentBackgroundImage
        }
    }// View
    
}


#Preview {
    SettingView()
        .environmentObject(BackgroundSettings())
}
