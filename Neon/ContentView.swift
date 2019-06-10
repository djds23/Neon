//
//  ContentView.swift
//  Neon
//
//  Created by Dean Silfen on 6/8/19.
//  Copyright © 2019 Dean Silfen. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject var parsedText: ParsedText
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(parsedText.sections) { section in
                        Section(header: Text(section.label).bold()) {
                            ForEach(section.texts) { text in
                                Text(text.value)
                            }
                        }
                    }
                }
                Text(parsedText.originalText)
                    .padding()
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                Spacer()
                
            }.navigationBarTitle(Text("Classified Text"))
        }
    }
}
