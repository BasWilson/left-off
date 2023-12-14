//
//  EditNoteSheet.swift
//  Left off
//
//  Created by Bas Wilson on 12/12/2023.
//

import SwiftUI

struct EditNoteSheet: View {
    
    @State private var note = ""
    private var onComplete: (_ note: String, _ saved: Bool) -> Void

    init(note: String = "", onComplete: @escaping (_ note: String, _ saved: Bool) -> Void) {
        self.note = note
        self.onComplete = onComplete
    }

    var body: some View {
        NavigationStack {
            
            VStack {
                                
                TextField(
                    text: $note,
                    axis: .vertical,
                    label: {
                        Text("Note")
                    }
                ).lineLimit(5, reservesSpace: true)
                    .frame(minWidth: 300, maxWidth: 300)
                
                Spacer().frame(height: 20)
                
                Button(
                    action: {
                        self.onComplete(self.note, true)
                    },
                    label: {
                        Text("Save")
                    }
                )
                .buttonStyle(.borderedProminent)
                
            }
            .padding()
            .navigationTitle("Where have you left off?")
#if os(iOS)
            .toolbar {
              ToolbarItem(placement: .topBarTrailing) {
                  Button("Close") {
                      self.onComplete(self.note, false)
                  }
              }
          }
#endif
        }
    }
}
