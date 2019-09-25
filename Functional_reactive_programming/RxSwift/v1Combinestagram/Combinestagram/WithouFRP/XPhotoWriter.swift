

import Foundation
import UIKit
import Photos

class XPhotoWriter {
    enum Errors: Error {
        case couldNotSavePhoto
    }
    
    static func save(_ image: UIImage, finished: @escaping (_ id: String?, _ error: Error?)-> Void) {
         var savedAssetId: String?
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
            savedAssetId = request.placeholderForCreatedAsset?.localIdentifier
        }, completionHandler: { success, error in
            DispatchQueue.main.async {
                if success, let id = savedAssetId {
                    finished(id,  nil)
                } else {
                    finished(nil, Errors.couldNotSavePhoto)
                }
            }
        })
    }
    
}
