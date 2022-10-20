//
//  Webster_s_Dictionary_macOSApp.swift
//  Webster's Dictionary macOS
//
//  Created by 李晨 on 2022/10/19.
//

import SwiftUI

@main
struct Webster_s_Dictionary_macOSApp: App {
    @State var isShowHelpPage = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 400,maxWidth: .infinity, minHeight: 450, maxHeight: .infinity)
        }
    }
}
