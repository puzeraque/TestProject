import UIKit

protocol ImageServiceProtocol {
    func saveImage(image: UIImage?, path: String) -> Bool
    func getSavedImage(named: String) -> UIImage?
}

final class ImageService: ImageServiceProtocol {
    static let shared: ImageServiceProtocol = ImageService()

    func saveImage(image: UIImage?, path: String) -> Bool {
        guard let data = image?.jpegData(compressionQuality: 1) else {
            return false
        }
        guard
            let directory = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask, appropriateFor: nil,
                create: false
            ) as NSURL
        else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(path)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) {
            return UIImage(
                contentsOfFile: URL(
                    fileURLWithPath: dir.absoluteString
                ).appendingPathComponent(named).path
            )
        }
        return nil
    }
}
