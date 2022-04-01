//
//  UIControl+Combine.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2022/03/31.
//  Copyright © 2022 417.72KI. All rights reserved.
//

#if canImport(UIKit)
import Combine
import UIKit

extension UIControl {
    func publisher(for event: UIControl.Event) -> AnyPublisher<Void, Never> {
        InteractionPublisher(control: self, event: event)
            .eraseToAnyPublisher()
    }
}

private extension UIControl {
    final class InteractionSubscription<S: Subscriber>: Subscription where S.Input == Void {
        private let subscriber: S?
        private let control: UIControl
        private let event: UIControl.Event

        init(subscriber: S,
             control: UIControl,
             event: UIControl.Event) {

            self.subscriber = subscriber
            self.control = control
            self.event = event
            self.control.addTarget(self, action: #selector(handleEvent), for: event)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {}

        @objc
        private func handleEvent(_ sender: UIControl) {
            _ = self.subscriber?.receive(())
        }
    }

    struct InteractionPublisher: Publisher {
        typealias Output = Void
        typealias Failure = Never

        private let control: UIControl
        private let event: UIControl.Event

        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }

        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
            let subscription = InteractionSubscription(
                subscriber: subscriber,
                control: control,
                event: event
            )
            subscriber.receive(subscription: subscription)
        }
    }
}
#endif
