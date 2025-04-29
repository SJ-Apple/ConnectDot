//
//  OnboardingTabView.swift
//  StellaMe
//
//  Created by JaeyoungLee on 4/29/25.
//

import SwiftUI

struct OnboardingTabView: View {
    @Binding var isFristLauncing: Bool
    
    var body: some View {
        TabView {
            // page1
            OnboardingPageView(imageName: "Star1", title: "작은 실천이 별이 됩니다", subtitle: "당신의 행동 하나가 별로 기록됩니다")
            // page2
            OnboardingPageView(imageName: "thirdStar", title: "별들이 모여 별자리를 만듭니다", subtitle: "당신만의 성취의 길이 만들어집니다")
            // page3
            OnboardingPageView(imageName: "OnboardingImageExmaple", title: "별마다 이야기를 담습니다", subtitle: "별을 클릭하면 그 날의 기록을 다시 볼 수 있어요!")
            // page4
            OnboardingPageView(imageName: "", title: "당신의 우주를 꾸며보세요", subtitle: "다양한 테마로 나만의 우주를 만들 수 있어요!")
            // page5
            OnboardingLastView(imageName: "", title: "성장하는 자신을 만나보세요", subtitle: "매일, 조금씩 더 빛나는 나를 만들어갑니다", isFirstLaunching: $isFristLauncing)
        } //: TabView
        .tabViewStyle(PageTabViewStyle())
    }
}

