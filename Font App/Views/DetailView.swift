//
//  DetailView.swift
//  Font App
//
//  Created by Weston Hanners on 12/11/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct DetailView: View {
        
    @State var selectedFont: CustomFont
    @State var showingLicense: Bool = false
    @State var pingInstallButton: Bool = false
    @Binding var installing: Bool
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach (selectedFont.files, id: \.self) { file in
                        NavigationLink(destination: ExpandedFontView(fontFamilyString: file)) {
                            Text(CustomFont.demoString)
                                .font(.custom(file, size: 20))
                        }
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
        }
        .navigationBarTitle(selectedFont.name)
        .navigationBarItems(trailing:
            Button(action: {
                self.pingInstallButton = false
                
                withAnimation() {
                    self.installing = true
                }
                
                self.selectedFont.register() { complete in
                    withAnimation() {
                        self.installing = false
                    }
                }
            }) {
                Image(systemName: "plus.circle")
                    .foregroundColor(.green)
            }
            .onAppear() {
                self.pingInstallButton = true
            }
            .scaleEffect(self.pingInstallButton ? 1.3 : 1)
            .opacity(self.pingInstallButton ? 0.5 : 1)
            .animation(Animation.easeInOut(duration: 0.8).repeatCount(self.pingInstallButton ? 1000 : -1, autoreverses: true).delay(0.5))
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(selectedFont: CustomFont(name: "Source Code Pro", license: "nil", files: ["SourceCodePro-Regular", "SourceCodePro-Bold"]), installing: .constant(false))
        }
    }
}
