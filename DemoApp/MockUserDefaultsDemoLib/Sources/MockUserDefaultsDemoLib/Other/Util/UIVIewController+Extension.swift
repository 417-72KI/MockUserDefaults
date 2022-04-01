//
//  UIVIewController+Extension.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {
    func back() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}
#endif
