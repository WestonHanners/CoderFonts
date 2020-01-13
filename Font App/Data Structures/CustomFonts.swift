//
//  CustomFonts.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI
import CoreText



struct CustomFonts: Codable {
    let fonts: [CustomFont]
    
    static func loadFonts() -> [CustomFont] {
        
        guard let url = Bundle.main.url(forResource: "fonts", withExtension: "json") else {
            debugPrint("Unable to find fonts JSON")
            return [CustomFont]()
        }
                
        guard let data = try? String(contentsOf: url).data(using: .utf8) else {
            debugPrint("Unable to load fonts JSON")
            return [CustomFont]()
        }
                
        let decoder = JSONDecoder()
        
        guard let customFonts = try? decoder.decode(CustomFonts.self, from: data) as CustomFonts else {
            return [CustomFont]()
        }
        
        return customFonts.fonts
    }
}

struct CustomFont: Codable, Identifiable {
    
    static let demoString = "The quick brown fox jumps over the lazy dog 0123456789"
    static let expandedDemoString =
    """
    abcdefghijklmnopqrstuvwxyz
    ABCDEFGHIJKLMNOPQRSTUVWXYZ
    0123456789
    !@#$%^&*()_+-=,
    ./;'[]\\<>?:"{}|
    """
    
    let id: UUID = UUID()
    let name: String
    let license: String
    let files: [String]
    
    var displayFont: Font {
        return Font.custom(files.first ?? "", size: 20)
    }
    
    var headingFont: Font {
        return Font.custom(files.first ?? "", size: 40)
    }
    
    func register(completion: @escaping (Bool)->()) {
        
        let qualifiedFonts = files.map({
            return Bundle.main.url(forResource: $0, withExtension: ".ttf")
        })
        
        let fonts: CFArray = qualifiedFonts as CFArray
            
        CTFontManagerRegisterFontURLs(fonts, .user, true) { (errors, done) -> Bool in
            if done {
                completion(true)
                return true
            } else {
                completion(false)
                return false
            }
        }
    }
}
