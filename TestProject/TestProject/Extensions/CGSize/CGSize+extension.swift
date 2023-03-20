import CoreGraphics

public extension CGSize {
    static func square(_ boundLength: CGFloat) -> Self {
        self.init(width: boundLength, height: boundLength)
    }
}
