import UIKit


extension StickerListViewController: knowMoreDelegate {
    
    func knowMoreDidtapAction(option: KnowMoreOption?) {
        
        if let option = option {
            
            switch option {
            case .stickerImage:
                openCamera()
                //handlerImage()
                break
            default: break
            }
        }
        
    }
    
    func knowMoreDidClose(option: KnowMoreOption?) {
        
        if let option = option {
            switch option {
            default:
                break
            }
        }
    }
    
}
