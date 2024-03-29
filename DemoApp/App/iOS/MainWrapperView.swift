//
//  MainWrapperView.swift
//  MockUserDefaultsDemo (iOS)
//
//  Created by 417.72KI on 2022/04/01.
//  Copyright © 2022 417.72KI. All rights reserved.
//

import SwiftUI

struct MainWrapperView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController()!
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct MainWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        MainWrapperView()
    }
}
