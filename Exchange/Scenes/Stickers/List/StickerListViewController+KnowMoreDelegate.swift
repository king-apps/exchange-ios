import UIKit


extension StickerListViewController: knowMoreDelegate {
    
    func knowMoreDidtapAction(option: KnowMoreOption?) {
        
        if let option = option {
            
            switch option {
            case .stickerImage:
                openCamera()
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
