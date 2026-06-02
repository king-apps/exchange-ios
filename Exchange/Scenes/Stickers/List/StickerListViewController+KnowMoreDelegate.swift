import UIKit


extension StickerListViewController: knowMoreDelegate {
    
    func knowMoreDidtapAction(option: KnowMoreOption?) {
        
        if let option = option {
            
            switch option {
            case .stickerImage:
                handlerImage()
                // TO-DO
                //openCamera()
                break
            default: break
            }
        }
        
    }
    
    func knoMoreDidClose(option: KnowMoreOption?) {
        
        if let option = option {
            switch option {
            default:
                break
            }
        }
    }
    
}
