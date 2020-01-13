//
//  ContentView.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var installing: Bool = false
    
    let fonts: [CustomFont]
    
    init() {
        self.fonts = CustomFonts.loadFonts()
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach (fonts) { font in
                        NavigationLink(destination: DetailView(selectedFont: font,
                                                               installing: self.$installing)) {
                            Text(font.name)
                                .font(font.displayFont)
                        }
                    }
                }
                .navigationBarTitle("Coder Fonts")
            }
            .blur(radius: self.installing ? 10 : 0)
            
            if (self.installing) {
                LoadingIndicator()
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
