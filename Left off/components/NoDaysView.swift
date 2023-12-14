//
//  NoDaysView.swift
//  Left off
//
//  Created by Bas Wilson on 14/12/2023.
//

import SwiftUI

struct NoDaysView: View {
    private var project: Project
    init(project: Project) {
        self.project = project
    }
    @EnvironmentObject var store: Store

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Welcome to your fresh project, get started by writing down where you've left off today")
#if os(iOS)
                .frame(minWidth: UIScreen.main.bounds.width - 30, maxWidth: UIScreen.main.bounds.width - 30, alignment: .topLeading)
#endif
#if os(macOS)
                .frame(minWidth: 300, maxWidth: .infinity, alignment: .topLeading)
#endif
            
            Button {
                store.navPath.append(.FinishUpScreen1)
            }
            label: {
                Image(systemName: "pencil")
                Text("Write down")
            }
                .buttonStyle(.borderedProminent)
        }

    }
}
