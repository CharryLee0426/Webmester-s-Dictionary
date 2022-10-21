//
//  HelpView.swift
//  Webster's Dictionary macOS
//
//  Created by 李晨 on 2022/10/21.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack {
            Image(systemName: "questionmark.circle")
                .resizable()
                .frame(width: 50, height: 50)
            
            Text("M-W Dictionary")
                .font(.largeTitle)
            Text("Created by Charry Lee")
                .font(.title2)
            HStack {
                Text("If you have any question, please contact ").font(.footnote)
                Link(destination: URL(string: "https://github.com/CharryLee0426")!) {
                    Text("Charry")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
            .padding([.leading, .trailing])
        }
        .padding()
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
