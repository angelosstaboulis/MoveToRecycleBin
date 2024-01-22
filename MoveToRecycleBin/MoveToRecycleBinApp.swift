//
//  MoveToRecycleBinApp.swift
//  MoveToRecycleBin
//
//  Created by Angelos Staboulis on 21/1/24.
//

import SwiftUI

@main
struct MoveToRecycleBinApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(directoryPath: "", selectedPath: "", presented: false)
                .frame(width:1200,height:700)
        }.windowResizability(.contentSize)
    }
}
