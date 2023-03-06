//
//  swiftappApp.swift
//  swiftapp
//
//  Created by user230926 on 12/31/22.
//

import SwiftUI

@main
struct swiftappApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
