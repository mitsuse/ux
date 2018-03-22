import UIKit

import RxSwift
import RxCocoa

public enum Keyboard: ReactiveCompatible {
    public struct Update {
        public let size: CGSize
        public let duration: Double
    }

    public struct Transition {
        public let last: CGSize
        public let next: CGSize
        public let duration: Double
    }
}

extension Reactive where Base == Keyboard {
    public static var willShow: Observable<Keyboard.Update> { return notifications(.UIKeyboardWillShow).map(extract) }
    public static var willHide: Observable<Keyboard.Update> { return notifications(.UIKeyboardWillHide).map(extract).map(zeroHeight) }
    public static var willChangeFrame: Observable<Keyboard.Update> { return notifications(.UIKeyboardWillChangeFrame).map(extract) }
    public static var didShow: Observable<Keyboard.Update> { return notifications(.UIKeyboardDidShow).map(extract) }
    public static var didHide: Observable<Keyboard.Update> { return notifications(.UIKeyboardDidHide).map(extract).map(zeroHeight) }
    public static var didChangeFrame: Observable<Keyboard.Update> { return notifications(.UIKeyboardDidChangeFrame).map(extract) }
}

extension Reactive where Base == Keyboard {
    public static var transitions: Observable<Keyboard.Transition> {
        let initial = Keyboard.Update(size: .zero, duration: 0)
        return
            willChangeFrame
                .scan((CGSize.zero, initial)) { state, next in let (_, previous) = state; return (previous.size, next) }
                .skip(1)
                .map { size, update in Keyboard.Transition(last: size, next: update.size, duration: update.duration) }
    }
}

private func notifications(_ name: Notification.Name) -> Observable<Notification> { return NotificationCenter.default.rx.notification(name) }

private func extract(_ notification: Notification) -> Keyboard.Update {
    return Keyboard.Update(
        size: (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size,
        duration: (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
    )
}

private func zeroHeight(_ update: Keyboard.Update) -> Keyboard.Update {
    return Keyboard.Update(
        size: CGSize(width: update.size.width, height: 0),
        duration: update.duration
    )
}
