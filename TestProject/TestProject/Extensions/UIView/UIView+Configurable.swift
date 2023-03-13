public protocol Configurable {
    associatedtype Model

    func configure(with model: Model)
}

extension Configurable {
    @discardableResult
    func configured(with model: Model) -> Self {
        configure(with: model)
        return self
    }
}
