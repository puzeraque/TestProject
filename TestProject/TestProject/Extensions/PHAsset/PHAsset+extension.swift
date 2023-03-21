import PhotosUI

extension PHAsset {
    static func getURL(
        ofPhotoWith mPhAsset: PHAsset,
        completionHandler : @escaping ((_ responseURL : URL?) -> Void)
    ) {
        if mPhAsset.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustMeta: PHAdjustmentData) -> Bool in
                return true
            }
            mPhAsset.requestContentEditingInput(
                with: options,
                completionHandler: { (contentEditingInput, info) in
                    if let fullSizeImageUrl = contentEditingInput?.fullSizeImageURL {
                        completionHandler(fullSizeImageUrl)
                    } else {
                        completionHandler(nil)
                    }
                }
            )
        } else if mPhAsset.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(
                forVideo: mPhAsset,
                options: options,
                resultHandler: { (asset, audioMix, info) in
                    if let urlAsset = asset as? AVURLAsset {
                        let localVideoUrl = urlAsset.url
                        completionHandler(localVideoUrl)
                    } else {
                        completionHandler(nil)
                    }
                }
            )
        }

    }
}
