//
//  DetailView.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let demoString = "The quick brown fox jumps over the lazy dog"
    
    @State var selectedFont: CustomFont
    @State var showingLicense: Bool = false
    @State var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach (selectedFont.files, id: \.self) { file in
                    Text(verbatim: self.demoString)
                        .font(.custom(file, size: 20))
                }
            }
            Spacer()
            Button(action: {
                self.showingLicense = true
            }) {
                Text("Show License")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showingLicense) {
                LicenseView(license: self.selectedFont.license)
            }
            
        }
        .alert(isPresented: $showingAlert, content: { Alert(title: Text("Complete")) })
        .navigationBarTitle(selectedFont.name)
        .navigationBarItems(trailing:
            Button(action: {
                registerFont(font: self.selectedFont) { complete in
                    self.showingAlert = true
                }
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            }
        )
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(selectedFont: CustomFont(name: "Hack", license: "nil", files: ["Hack-Regular", "Hack-Bold"]))
        }
    }
}
