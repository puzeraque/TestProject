import Foundation

extension String {
    func ranges(
        of substring: String,
        options: CompareOptions = [],
        locale: Locale? = nil
    ) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while (ranges.last.map { $0.upperBound < self.endIndex }) ?? true,
              let range = self.range(
                of: substring,
                options: options,
                range: (ranges.last?.upperBound ?? self.startIndex) ..< self.endIndex, locale: locale
              )
        {
            ranges.append(range)
        }
        return ranges
    }
}
