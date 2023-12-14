//
//  DetailView.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import SwiftUI

struct FinishUpScreen2: View {

    @EnvironmentObject var store: Store

    var dateFormatter: DateFormatter
    
    @State private var note2 = ""


    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.locale = Locale(identifier: "nl_NL")
    }
    
    var body: some View {
        ScrollView() {
            
            HStack {
                TextField(
                    text: $note2,
                    axis: .vertical,
                    label: {
                        Text("Any notes to help you next time when you pick up this project?")
                            .foregroundStyle(.black)

                    }
                ).lineLimit(5, reservesSpace: true)
                .foregroundStyle(.black)
                .padding()
            }
            .background(.yellow)
            .cornerRadius(8)

            Spacer().padding()
            
            Button(action: {
                store.project!.addDay(note1: store.note1, note2: note2)
                store.note1 = ""
                store.navPath.removeLast(store.navPath.count - 1) // go to detail view
            }, label: {
                Text("Finish up")
                Image(systemName: "checkmark.circle.fill")
            })
            .buttonStyle(.borderedProminent)

        }
        .navigationBarBackButtonHidden(false)
        .padding()
        .navigationTitle("Finish up")
        #if os(macOS)
        .navigationSubtitle(dateFormatter.string(from: Date()))
        #endif
    }
}
