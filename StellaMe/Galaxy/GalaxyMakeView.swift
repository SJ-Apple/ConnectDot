//
//  GalaxyMakeView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/25/25.
//

import SwiftUI

struct GalaxyMakeView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var newGalaxyName: String
    @Binding var isPresented: Bool
    
    @State private var galaxyTitle: String = ""
    @State private var selectedImageName: String? = nil
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack {
            Image("BG")
                .resizable()
            
            VStack {
                Text("별자리 만들기")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 100)
                
                
                TextField("별자리 이름 작성하기", text: $galaxyTitle)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300, height: 50)
                
                Spacer()
                    .frame(height: 50)
                
                
                Button {
                    if !galaxyTitle.isEmpty, let selectedImageName = selectedImageName { // 옵셔널 바인딩으로 처리
                        newGalaxyName = galaxyTitle
                        let newGalaxy = GalaxyModel(
                            id: UUID(),
                            title: galaxyTitle,
                            galaxyImageName: selectedImageName,
                            galaxyStars: []
                        )
                        modelContext.insert(newGalaxy)
                        try? modelContext.save()
                        dismiss()
                    }
                } label: {
                    VStack {
                        HStack {
                            ForEach(["firstStar", "secondStar", "thirdStar", "fourthStar", "fifthStar"], id: \.self) { imageName in
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 65,height: 65)
                                    .border(selectedImageName == imageName ? Color.yellow : Color.clear, width: 2)
                                    .onTapGesture {
                                        selectedImageName = imageName
                                    }
                            }
                        }
                        Spacer()
                            .frame(height: 70)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.yellow)
                            .frame(width: 150, height: 50)
                            .overlay {
                        Text("별자리 생성")
                            .foregroundStyle(.white)
                            }
                    
                    }
                }
                
            }
        }
        .ignoresSafeArea()
    } //: body
}


#Preview {
    GalaxyMakeView(newGalaxyName: .constant(""), isPresented: .constant(true))
}
