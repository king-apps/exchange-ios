import UIKit


extension ProfileListViewController: knowMoreDelegate {
    
    func knowMoreDidtapAction(option: KnowMoreOption?) {
    
        if let option = option {
            switch option {
            case .deleteAccount:
                confirmDeleteAccount()
                break
            default:
                break
            }
        }
    }
    
    func knowMoreDidClose(option: KnowMoreOption?) {
        
    }
}
