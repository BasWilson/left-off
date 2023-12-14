//
//  DetailView.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import SwiftUI

struct FinishUpScreen1: View {

    var dateFormatter: DateFormatter
    @EnvironmentObject var store: Store

    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.locale = Locale(identifier: "nl_NL")
    }
    
    var body: some View {
        ScrollView() {
            HStack {
                TextField(
                    text: $store.note1,
                    axis: .vertical,
                    label: {
                        Text("Where have you left off?")
                            .foregroundStyle(.black)
                    }
                ).lineLimit(5, reservesSpace: true)
                    .foregroundStyle(.black)
                    .padding()
            }
            .background(.yellow)
            .cornerRadius(8)
            
            Spacer().padding()

            Button {
                store.navPath.append(.FinishUpScreen2)
            } label: {
                Text("Next")
                Image(systemName: "arrow.right.circle")

            }
            .buttonStyle(.bordered)
        }
        .navigationBarBackButtonHidden(false)
        .padding()
        .navigationTitle("Finish up")
        #if os(macOS)
        .navigationSubtitle(dateFormatter.string(from: Date()))
        #endif
    }
}
