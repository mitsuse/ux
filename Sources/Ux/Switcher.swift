import UIKit

import ScreenContainer

public final class Switcher<State>: UIViewController, ScreenContainer.Default {
    private let create: (State) -> UIViewController

    private var constraints = [NSLayoutConstraint]()

    private var currentContent: UIViewController? {
        didSet {
            if let content = oldValue { remove(content: content) }
            if let content = currentContent { content.view.translatesAutoresizingMaskIntoConstraints = false; add(content: content) }
        }
    }

    public var state: State {
        didSet {
            currentContent = create(state)
        }
    }

    public init(_ initialState: State, _ create: @escaping (State) -> UIViewController) {
        self.create = create
        self.state = initialState

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        view = SwitcherView()
    }

    public override func updateViewConstraints() {
        view.removeConstraints(constraints)
        if let content = currentContent {
            constraints = [
                content.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                content.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                content.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                content.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            ]
        }
        view.addConstraints(constraints)

        super.updateViewConstraints()
    }
}

private final class SwitcherView: UIView {
    override class var requiresConstraintBasedLayout: Bool { return true }
}