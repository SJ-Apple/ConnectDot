//
//  MakeAndSelectView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/25/25.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - galaxymodel에서 선언한 텍스트(여러개), 별 이미지 선택을 저장 및 넘어갈 수 있도록 함.
struct MakeAndSelectView: View {
    @State private var selectedOption = "새로운 별 만들기"
    let dropDownOption = ["새로운 별 만들기", "새로운 별자리로 보내기", "기존 별자리1", "기존 별자리2"]
    
    @Environment(\.modelContext) var GalaxyModelContext
    @Environment(\.modelContext) var StarModelContext
    
    @State private var GalaxyText: String = ""
    @State private var selectedGalaxyImage: String = ""
    @State private var todayText: String = ""
    
    
    var galaxyModel: GalaxyModel?
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
                .font(.system(size: 40))
            
            TextField("하루 일과", text: $todayText)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300, height: 40)
            
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 200, height: 50)
                    .overlay {
                        Text("하늘로 보내기")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                    }
            } //: Label
            
            Button {
                /*
                 1. 갤럭시를 선택하지 않으면 보내기 버튼 enabled
                 2. 갤럭시를 드롭다운에서 예를 들어 galaxyA를 선택하면 보내기 버튼이 활성화.
                 3. galaxyA를 선택하고, 하루일과 입력하고, 하늘로 보내기 누르면 galaxyA에 추가됨.
                 */
                
            } label: {
                Picker("selectOption", selection: $selectedOption) {
                    ForEach(dropDownOption, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 60, height: 50)
                    .overlay {
                        Text("보내기")
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}

// MARK: - submit 버튼을 누르면 homeView로 넘어가고 저장한 별자리 이미지를 homeview에 넘겨줌.

#Preview {
    MakeAndSelectView()
}

