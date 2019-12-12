//
//  LicenseView.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct LicenseView: View {
    @State var license: String
    
    var body: some View {
        VStack {
            Text("License")
                .font(.largeTitle)
                .padding()
            ScrollView {
                Text(license)
                    .padding()
            }
            Spacer()
        }
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView(license: "Hello World")
    }
}
