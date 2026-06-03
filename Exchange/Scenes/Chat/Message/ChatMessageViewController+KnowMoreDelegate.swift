import UIKit


extension ChatMessageViewController: knowMoreDelegate {
    
    func knowMoreDidtapAction(option: KnowMoreOption?) {
        
        if let option = option {
            
            switch option {
            case .denunciate:
                confirmDenunciate()
                break
            case .denunciateSuccess:
                onDenunciateSuccess()
                break
            default: break
            }
        }
        
    }
    
    func knowMoreDidClose(option: KnowMoreOption?) {
        
        if let option = option {
            switch option {
          //     onDenunciateSuccess()
          //      break
            default:
                break
            }
        }
    }
    
}
