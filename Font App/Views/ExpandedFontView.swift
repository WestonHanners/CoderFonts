//
//  ExpandedFontView.swift
//  Font App
//
//  Created by Weston Hanners on 12/12/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct ExpandedFontView: View {
    
    let fontFamilyString: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(fontFamilyString)
                    .font(.headline)
                Text(CustomFont.expandedDemoString)
                    .font(Font.custom(fontFamilyString, size: 60))
            }
        }
        .navigationBarTitle("Font Details")
    }
}

struct ExpandedFontView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedFontView(fontFamilyString: "Hack-Bold")
    }
}
