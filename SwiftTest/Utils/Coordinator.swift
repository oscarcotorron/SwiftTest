//
//  Coordinator.swift
//  SwiftTest
//
//  Created by Oscar Hernandez on 19/07/23.
//

import SwiftUI

enum Page: String, Identifiable {
    case setup, comments
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedAlarmType: AlarmType = .soundAndVibration
    @Published var selectedSound: SoundType = .sound1
    @Published var selectedVibration: VibrationType = .vibration1
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .setup:
            SetupView()
        case .comments:
            CommentsView()
        }
    }
}
