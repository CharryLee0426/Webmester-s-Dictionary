//
//  Dictionary.swift
//  Webster's Dictionary macOS
//
//  Created by 李晨 on 2022/10/19.
//

import Foundation

struct Meta: Codable {
    let id: String
    let uuid: UUID
    let sort: String
    let src: String
    let section: String
    let stems: [String]
    let offensive: Bool
}
struct dicResult: Codable, Identifiable {
    // this id is meaningless, just used to implement Identifiable protocol
    let id = UUID()
    let meta: Meta
    let shortdef: [String]
}

// Get results from Webster's Dictionary
func getDictionary(word: String, key: String) async throws -> [dicResult] {
    // URL cannot be created if word(or phase) contains spaces.
    let stringURL = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/" + word.filter { !$0.isWhitespace } + "?key=" + key
    guard let url = URL(string: stringURL) else {
        fatalError("Cannot create URL")
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        fatalError("Http GET request error")
    }
    let jsonResult = try JSONDecoder().decode([dicResult].self, from: data)
    print("\(word) returned \(jsonResult.count) result(s)!")
    return jsonResult
}

// Get today(GMT-4, EST)'s API usage
func getAPIUsage(key: String) async throws -> Int {
    let stringURL = "https://www.dictionaryapi.com/lapi/v3/get_monthly_stats?key=" + key
    guard let url = URL(string: stringURL) else {
        fatalError("URL Cannot created")
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        fatalError("Http GET request error")
    }
    
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(abbreviation: "EST")
    let stringDate = dateFormatter.string(from: now)
    
    // JSONSerialization will convert data object to NSDictionary or NSArray
    // as! is needed for down-casting, Any -> NSDictionary in this situation
    let total: NSDictionary = try JSONSerialization.jsonObject(with: data) as! NSDictionary
    let today: NSDictionary = total[stringDate] as! NSDictionary
    let usage: Int = today["total"] as! Int
    
    return usage
}
