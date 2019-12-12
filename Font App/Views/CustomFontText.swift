//
//  CustomFontText.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct CustomFontText: View {
    @State var font: CustomFont
    @State var text: String
    var body: some View {
        Text(text)
            .font(font.headingFont)
    }
}

struct CustomFontText_Previews: PreviewProvider {
    static var previews: some View {
        CustomFontText(font: CustomFont(name: "Hack", license: "nil", files: ["Hack-Regular", "Hack-Bold"]), text: "Hello")
    }
}
