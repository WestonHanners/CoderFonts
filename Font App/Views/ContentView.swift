//
//  ContentView.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let fonts: [CustomFont]
    
    init() {
        self.fonts = CustomFonts.loadFonts()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach (fonts) { font in
                    NavigationLink(destination: DetailView(selectedFont: font)) {
                        Text(font.name)
                            .font(font.displayFont)
                    }
                }
            }
            .navigationBarTitle("Coder Fonts")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
