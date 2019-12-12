//
//  CustomFonts.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI
import CoreText

func registerFont(font: CustomFont, completion: @escaping (Bool)->()) {
    
    let fonts: CFArray = font.files as CFArray
    
    let bundle = CFBundleGetMainBundle()
    
    CTFontManagerRegisterFontsWithAssetNames(fonts, bundle, .user, true) { (errors, done) -> Bool in
        if done {
            completion(true)
            return true
        } else {
            completion(false)
            return false
        }
    }
}

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
}
