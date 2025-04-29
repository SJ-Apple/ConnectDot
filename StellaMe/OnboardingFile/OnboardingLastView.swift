//
//  OnboardingLastView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/29/25.
//

import SwiftUI

struct OnboardingLastView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack {
            Image(imageName)
            
            Text(title)
            
            Text(subtitle)
            
            Button {
                isFirstLaunching.toggle()
            } label: {
                Text("Start")
                    .padding()
                    .bold()
                    .frame(width: 200, height: 50)
                    .foregroundStyle(.white)
                    .background(Color.black)
                    .cornerRadius(20)
            }

        }
    }
}


