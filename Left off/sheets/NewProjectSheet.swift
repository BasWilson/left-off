//
//  EditNoteSheet.swift
//  Left off
//
//  Created by Bas Wilson on 12/12/2023.
//

import SwiftUI

struct NewProjectSheet: View {
    
    @Environment(\.modelContext) private var modelContext

    @State private var name = ""
    private var onComplete: (_ project: Project?, _ saved: Bool) -> Void

    init(onComplete: @escaping (_ project: Project?, _ saved: Bool) -> Void) {
        self.onComplete = onComplete
    }

    var body: some View {
        NavigationStack {
            
            VStack {
                                         
                VStack {
                    
                    TextField(
                        text: $name,
                        label: {
                            Text("Project name")
                        }
                    ).textFieldStyle(.automatic)
                        .padding(.vertical)
                        .multilineTextAlignment(.center)
                }

                Spacer()


                #if os(macOS)
                HStack() {
                    
                    Button(
                        action: {
                            self.onComplete(nil, false)
                        },
                        label: {
                            Text("Close")
                        }
                    )
                    
                    Button(
                        action: {
                            let newProject = self.addItem()
                            self.onComplete(newProject, true)
                        },
                        label: {
                            Text("Create")
                        }
                    )
                }
                #endif
                #if os(iOS)
                Button(
                    action: {
                        let newProject = self.addItem()
                        self.onComplete(newProject, true)
                    },
                    label: {
                        Text("Create Project")
                        Image(systemName: "plus.circle.fill")

                    }
                )
                .buttonStyle(.borderedProminent)
                .frame(width: .infinity)
                #endif
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Project")
#if os(iOS)
            .toolbar {
              ToolbarItem(placement: .topBarTrailing) {
                  Button("Close") {
                      self.onComplete(nil, false)
                  }
              }
          }
#endif

        }
    }
    
    private func addItem() -> Project {
        let newItem = Project(name: self.name)
        withAnimation {
            modelContext.insert(newItem)
        }
        return newItem
    }
}
