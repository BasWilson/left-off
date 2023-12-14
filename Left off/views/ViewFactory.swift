//

import Foundation
import SwiftUI

enum AppView {
    case IndexView
    case DetailView
    case FinishUpScreen1
    case FinishUpScreen2
    case NewProject
}

class ViewFactory {
    @ViewBuilder
    static func viewForDestination(_ destination: AppView) -> some View {
        switch destination {
        case .DetailView:
            DetailView()
        case .FinishUpScreen1:
            FinishUpScreen1()
        case .IndexView:
            IndexView()
        case .FinishUpScreen2:
            FinishUpScreen2()
        case .NewProject:
            NewProject()
        }
    }
}
