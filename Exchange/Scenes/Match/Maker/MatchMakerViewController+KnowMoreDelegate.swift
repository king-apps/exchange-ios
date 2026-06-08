import UIKit


extension MatchMakerViewController: knowMoreDelegate {
    
    func knowMoreDidtapAction(option: KnowMoreOption?) {
        
        if let option = option {
            
            switch option {
            case .boostProfile:
                boostProfile()
                break
            case .superLikeSuccess:
                onSuperLikeSuccess()
            case .denunciate:
                handlerDenunciate()
            case .denunciateSuccess:
                onDenunciateSuccess()
                break
            case .matchMakerAddProduct:
                setTabBarSelectedIndex(index: 0)
            case .matchMakerNeedLocation:
                openSeetingsLocation()
                break
            default: break
            }
        }
        
    }
    
    func knowMoreDidClose(option: KnowMoreOption?) {
        
        if let option = option {
            switch option {
            case .superLikeSuccess:
                onSuperLikeSuccess()
            case .denunciateSuccess:
                onDenunciateSuccess()
                break
            default:
                break
            }
        }
    }
    
}
