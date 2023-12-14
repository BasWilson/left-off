//
//  NoteView.swift
//  Left off
//
//  Created by Bas Wilson on 14/12/2023.
//

import SwiftUI

enum Note {
    case note1
    case note2
}

struct NoteView: View {
    
    private var project: Project
    private var note: Note
    private var dayId: String
    private var day: Day
    @State var showEditSheet = false
    
    init(note: Note, project: Project, dayId: String) {
        self.note = note
        self.project = project
        self.dayId = dayId
        let foundDay = project.days.first(where: {$0.id == dayId})
        if (foundDay != nil) {
            self.day = foundDay!
        } else {
            if (project.days.isEmpty) {
                project.addDay(note1: "", note2: "")
            }
            self.day = project.days.last!
        }
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(self.note == .note1 ? "Left off" : "Extra notes")
                .padding(.top)
                .padding(.horizontal)
                .font(.headline)
                .foregroundStyle(.black)
            let scopeNote = self.note == .note1 ?  self.day.note1 : self.day.note2
            
            Text(scopeNote.count > 0 ? scopeNote : "No note yet")
                .padding(.top)
                .padding(.horizontal)
                .foregroundStyle(.black)
#if os(iOS)
                .frame(minWidth: UIScreen.main.bounds.width - 30, maxWidth: UIScreen.main.bounds.width - 30, alignment: .topLeading)
#endif
#if os(macOS)
                .frame(minWidth: 300, maxWidth: .infinity, alignment: .topLeading)
#endif
                        
            if (scopeNote.count > 0) {
                Button(action: {
                    self.showEditSheet = true
                }) {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
                .padding()
                .buttonStyle(.borderless)
                .foregroundColor(.black)
            } else {
                Spacer(minLength: 20)
            }
        }
        .background(.yellow)
        .cornerRadius(8)
        .sheet(isPresented: $showEditSheet, content: {
            let scopeNote = self.note == .note1 ?  self.day.note1 : self.day.note2

            EditNoteSheet(
                note: scopeNote,
                onComplete: {
                    note,
                    saved in
                    if (saved == true) {
                        if (self.note == .note1) {
                            self.day.note1 = note
                        } else {
                            self.day.note2 = note
                        }
                    }
                    self.showEditSheet = false
                })
        })
    }
}
