//
//  ContentView.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import SwiftUI
import SwiftData

struct IndexView: View {

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Project.lastUpdated, order: .forward) private var projects: [Project]
    @State var showNewProjectSheet = false
    @EnvironmentObject var store: Store

    var body: some View {
        #if os(macOS)
        NavigationSplitView {
            List(projects, selection: $store.project) { project in
                NavigationLink(
                    value: project,
                    label: {
                    Text(project.name)
                })
            }
            .navigationSplitViewColumnWidth(min: 200, ideal: 200, max: 300)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        self.showNewProjectSheet = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Projects")
            .sheet(isPresented: $showNewProjectSheet, content: {
                    NewProjectSheet(
                        onComplete: {
                            project,
                            saved in
                            self.showNewProjectSheet = false
                            if (saved == true) {
                                if (project != nil) {
                                    store.project = project
                                    store.navPath.append(.DetailView)
                                }
                            }
                    })
                })
        } detail: {
            if (store.project != nil) {
                NavigationStack(path: $store.navPath) {
                    DetailView()
                        .navigationDestination(for: AppView.self) { appview in
                            ViewFactory.viewForDestination(appview)
                        }
                }
            } else {
                Text("Select or create a project")
            }
        }
        #endif
        
        #if os(iOS)
            List {
                ForEach(projects, id: \.id) { project in
                    Button(action: {
                        store.project = project
                        store.navPath.append(.DetailView)
                    }) {
                        Text(project.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        self.showNewProjectSheet = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Projects")
            .sheet(isPresented: $showNewProjectSheet, content: {
                    NewProjectSheet(
                        onComplete: {
                            project,
                            saved in
                            self.showNewProjectSheet = false
                            if (saved == true) {
                                if (project != nil) {
                                    store.project = project
                                    store.navPath.append(.DetailView)
                                }
                            }
                    })
                })
        #endif

    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(projects[index])
            }
        }
    }
}
