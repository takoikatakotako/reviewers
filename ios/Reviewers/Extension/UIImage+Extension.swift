import UIKit

extension UIImage {
    func resized(maxEdgeLength: CGFloat) -> UIImage {
        // どちらかが 1000 以上であればリサイズ
        let originWidth = size.width
        let originHeight = size.height

        if maxEdgeLength < originWidth || maxEdgeLength < originHeight {
            // リサイズを行う
            let resizedSize: CGSize
            if originWidth < originHeight {
                // 縦長の場合
                resizedSize = CGSize(width: maxEdgeLength * originWidth / originHeight, height: maxEdgeLength)
            } else {
                // 横長の場合
                resizedSize = CGSize(width: maxEdgeLength, height: maxEdgeLength * originHeight / originWidth)
            }

            return UIGraphicsImageRenderer(size: resizedSize, format: imageRendererFormat).image {
                _ in draw(in: CGRect(origin: .zero, size: resizedSize))
            }
        } else {
            return self
        }
    }
}
