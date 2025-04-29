//
//  OnboardingPageView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/29/25.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
            Text(subtitle)
        }
    }
}

#Preview {
    OnboardingPageView(imageName: "", title: "", subtitle: "")
}
