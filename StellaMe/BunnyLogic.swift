//
//  BunnyLogic.swift
//  StellaMe
//
//  Created by Page의 Macbook on 4/28/25.
//

import SwiftUI
import Foundation
import Lottie

struct BunnyView: UIViewRepresentable {
    var fileName: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let animationView = LottieAnimationView(name: fileName)
        animationView.loopMode = .autoReverse
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        animationView.animation = LottieAnimation.named(fileName)
        animationView.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
