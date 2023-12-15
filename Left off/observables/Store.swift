//
//  ProjectManager.swift
//  Left off
//
//  Created by Bas Wilson on 13/12/2023.
//

import Foundation
import SwiftUI

class Store: ObservableObject{
    @Published var navPath = [AppView]()
    @Published var foodPath = [AppView]()

    @Published var note1 = ""
    @Published var project: Project?
}
