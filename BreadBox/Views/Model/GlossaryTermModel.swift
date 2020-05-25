//
//  GlossaryTermModel.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/24/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import Foundation

struct GlossaryTermModel: Codable, Identifiable {
    let id = UUID()
    var term: String
    var definition: String
}

let glossaryData: [GlossaryTermModel] = load("bakingTerms.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Could not find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Could not parse \(filename) as \(T.self):\n\(error)")
    }
}
