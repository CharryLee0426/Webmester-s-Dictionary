//
//  ContentView.swift
//  Webmester's Dictionary
//
//  Created by 李晨 on 2022/10/17.
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
                    .bold()
                    .font(.title)
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Text("Today's usage: \(usage) / 10,000")
                .font(.title2)
                .foregroundColor(.secondary)
            
            if results != nil {
                Form {
                    ForEach(results!) { result in
                        Section(header: Text(result.meta.id).font(.headline)) {
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
                HStack {
                    Text("Don't have a key? Get one at ")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Link("https://www.dictionaryapi.com/", destination: URL(string: "https://www.dictionaryapi.com/")!)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
