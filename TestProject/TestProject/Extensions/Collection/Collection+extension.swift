public extension Collection {
    /// Returns true if the collection is not empty
    var isNotEmpty: Bool {
        return !isEmpty
    }

    var nilIfEmpty: Self? {
        return isNotEmpty ? self : nil
    }
}