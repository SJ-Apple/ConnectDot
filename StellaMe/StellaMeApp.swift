//
//  StellaMeApp.swift
//  StellaMe
//
//  Created by Hazel on 4/24/25.
//

import SwiftUI
import SwiftData

@main
struct StellaMeApp: App {
    @StateObject private var backgroundSettings = BackgroundSettings()
    @State private var container: ModelContainer = {
        let schema = Schema([StarModel.self, GalaxyModel.self])
        return try! ModelContainer(for: schema)
    }()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .modelContainer(container)
                    .environmentObject(backgroundSettings)
            }
        }
    }
}
