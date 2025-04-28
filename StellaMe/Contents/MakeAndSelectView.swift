//
//  MakeAndSelectView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/24/25.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - galaxymodel에서 선언한 텍스트(여러개), 별 이미지 선택을 저장 및 넘어갈 수 있도록 함.
struct MakeAndSelectView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedOption = "새로운 별 만들기"
    @State private var moveToGalaxyMakeView: Bool = false
    @State private var newGalaxyName: String = ""
    
    
    @Query private var galaxyMemory: [GalaxyModel]
    @Query private var starMemory: [StarModel]
    
    // 임시
    @State private var GalaxyText: String = ""
    @State private var selectedGalaxyImage: String = ""
    @State private var todayText: String = ""
    
    var dropDownOption: [String] {
        var options = ["새로운 별 만들기", "새로운 별자리 만들기"]
        options += galaxyMemory.map { $0.title }
        return options
    }
    
    var galaxyModel: GalaxyModel?
    var starModel: StarModel?
    
    var body: some View {
        ZStack {
            Image("BG")
                .resizable(resizingMode: .stretch)
            
            VStack {
                
                Spacer()
                Spacer()
                
                
                HStack {
                    Text("별")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                        .multilineTextAlignment(.center)
                    Text("볼 일 없는 일상도")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                }
                HStack {
                    Text("여기에서는")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Text("별")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                        .multilineTextAlignment(.center)
                    Text("나요")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, -8.0)
                }
                
                Image("MakeAndSelectViewStar")
                    .resizable()
                    .frame(width: 200, height: 230)
                    
                
                Spacer()
                
                
                TextField("오늘 무슨 일을 하셨나요?", text: $todayText)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300, height: 40)
                
                
                // MARK: - 하늘로 보내기 버튼
//                Button {
//                    saveStar(text: todayText)
//                } label: {
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(width: 200, height: 50)
//                        .overlay {
//                            Text("하늘로 보내기")
//                                .font(.headline)
//                                .bold()
//                                .foregroundStyle(.white)
//                        }
//                    
//                } //: Label
                
                /*
                 1. 갤럭시를 선택하지 않으면 보내기 버튼 enabled
                 2. 갤럭시를 드롭다운에서 예를 들어 galaxyA를 선택하면 보내기 버튼이 활성화.
                 3. galaxyA를 선택하고, 하루일과 입력하고, 하늘로 보내기 누르면 galaxyA에 추가됨.
                 */
                
                // MARK: - 드롭다운 휠 형식 구현 로직
                Picker("selectOption", selection: $selectedOption) {
                    ForEach(dropDownOption, id: \.self) {
                        Text($0)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 300, height: 180)
                .onChange(of: selectedOption) {
                    if selectedOption == "새로운 별자리 만들기" {
                        moveToGalaxyMakeView = true
                    }
                }
                
                
                
                // MARK: - 나의 별자리로 보내기 버튼
                Button {
                    // 드롭다운에서 선택된 galaxy 이름과 매칭되는 GalaxyModel을 찾기
                    if let galaxy = galaxyMemory.first(where: { $0.title == selectedOption }) {
                        galaxy.galaxyTexts.append(todayText)
                        todayText = ""
                        try? modelContext.save()
                        dismiss()
                    }
                    todayText = "" // 텍스트 입력창 초기화
                    
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.yellow)
                        .frame(width: 150, height: 50)
                        .overlay {
                            Text("하늘에 수놓기")
                                .bold()
                                .foregroundStyle(.white)
                            
                        }
                }
                .padding(.top, 50.0)
                Spacer(minLength: 0)
            }
        }
        .ignoresSafeArea(.all)
        .sheet(isPresented: $moveToGalaxyMakeView) {
            GalaxyMakeView(newGalaxyName: $newGalaxyName, isPresented: $moveToGalaxyMakeView)
        }
        .onChange(of: moveToGalaxyMakeView) {
            if moveToGalaxyMakeView == false && !newGalaxyName.isEmpty {
                selectedOption = newGalaxyName
                newGalaxyName = "" // 하루 일과 보낸후 텍스트 입력창 초기화
                //                modelContext.insert(newGalaxy)
            }
        }
    }
    func saveStar(text: String) {
        let newStar = StarModel(starID: UUID(), starText: text, date: Date())
        modelContext.insert(newStar)
        do {
            print("\(text)가 저장되었어")
            try modelContext.save()
            dismiss()
        } catch {
            print("Error saving StarModel: \(error)")
        }
    }
}

// MARK: - submit 버튼을 누르면 homeView로 넘어가고 저장한 별자리 이미지를 homeview에 넘겨줌.

#Preview {
    MakeAndSelectView()
}

