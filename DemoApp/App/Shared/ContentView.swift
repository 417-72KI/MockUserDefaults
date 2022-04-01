//
//  ContentView.swift
//  Shared
//
//  Created by 417.72KI on 2022/04/01.
//  Copyright © 2022 417.72KI. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        #if os(iOS)
        MainWrapperView()
        #else
        // TODO: implement other view
        Text("Hello, world!")
            .padding()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
