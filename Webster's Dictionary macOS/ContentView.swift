//
//  ContentView.swift
//  Webster's Dictionary macOS
//
//  Created by 李晨 on 2022/10/19.
//

import SwiftUI

// UI Implementation
struct ContentView: View {
    @State var word: String = ""
    @State var key: String = ""
    @State var results: [dicResult]?
    @State var usage: Int = 0
    
    var body: some View {
        VStack {
            if results != nil {
                Spacer()
            }
            HStack {
                Spacer()
                if results == nil {
                    TextField("Your Collegiate Dictionary API Key", text: $key)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                }
                TextField("Word you wanna search(Usage is 0 before first search)", text: $word)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Spacer()
            }
            Button {
                Task {
                    results = try await getDictionary(word: word, key: key)
                    usage = try await getAPIUsage(key: key)
                }
            } label: {
                Text("Search!")
                    .frame(width: 140)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Text("Today's usage: \(usage) / 10,000")
                .font(.title2)
                .foregroundColor(.secondary)
            
            if results != nil {
                ScrollView(showsIndicators: true) {
                    ForEach(results!) { result in
                        Section(header: HStack{Text(result.meta.id).font(.headline)
                                .padding(.leading)
                            Spacer()}) {
                            HStack {
                                VStack(alignment: .leading) {
                                    ForEach(result.shortdef, id: \.self) { def in
                                        Text(def + ";")
                                            .italic()
                                            .font(.subheadline)
                                            .textSelection(.enabled)
                                            .padding([.leading, .bottom])
                                        Divider()
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                }
            } else {
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
