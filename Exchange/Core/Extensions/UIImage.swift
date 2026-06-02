import UIKit
import Foundation


extension UIImage {
    
    
    func icon(_ icon: AppTheme.Icon) -> UIImage {
        if let image = UIImage(named: icon.rawValue) {
            return image
        }
        else {
            return UIImage()
        }
    }
    
    
    func crop(width:CGFloat, height:CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
        let origin = CGPoint(x: rect.origin.x * CGFloat(-1), y: rect.origin.y * CGFloat(-1))
        self.draw(at: origin)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return result!
        
    }
    
    
    func resize(to:CGSize) -> UIImage? {
        
        let size = self.size
        
        let widthRatio  = to.width  / size.width
        let heightRatio = to.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}
