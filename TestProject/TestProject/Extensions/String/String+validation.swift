import Foundation

fileprivate enum Constant {
    static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let format = "SELF MATCHES %@"
}

extension String {

    var isValidEmail: Bool {
        let emailPredicate = NSPredicate(format: Constant.format, Constant.emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
}
