//
//  UITextField+Combine.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2022/03/31.
//  Copyright © 2022 417.72KI. All rights reserved.
//

#if canImport(UIKit)
import Combine
import UIKit

public extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
#endif
