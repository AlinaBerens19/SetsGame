//
//  SetGameApp.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 05/12/2021.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(game: SetGameViewModel())
        }
    }
}
