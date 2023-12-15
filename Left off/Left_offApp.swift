//
//  Left_offApp.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import SwiftUI
import SwiftData



@main
struct Left_offApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Project.self,
            Day.self,
            Food.self,
            DrinkDay.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @ObservedObject var store = Store()
    
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            IndexView()
            .environmentObject(store)
        }
        .modelContainer(sharedModelContainer)
        #endif
        
        #if os(iOS)
        WindowGroup {
            TabView {
                NavigationStack(path: $store.navPath) {
                    IndexView()
                        .navigationDestination(for: AppView.self) { appview in
                            ViewFactory.viewForDestination(appview)
                        }
                }
                .environmentObject(store)
                .tabItem {
                    Label("Left off", systemImage: "folder.fill")
                }
                
                NavigationStack(path: $store.foodPath) {
                    Image(systemName: "door.garage.double.bay.closed.trianglebadge.exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                    Text("Work in progress")
                        .navigationTitle("Food")
                }
                .environmentObject(store)
                .tabItem {
                    Label("Food", systemImage: "fork.knife")
                }
                
                NavigationStack {
                    DrinksView()
                }
                .environmentObject(store)
                .tabItem {
                    Label("Coffee", systemImage: "mug.fill")
                }
            }

        }
        .modelContainer(sharedModelContainer)
        #endif
    }
}
