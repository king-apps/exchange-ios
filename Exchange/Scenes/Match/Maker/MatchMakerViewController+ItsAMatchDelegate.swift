import Foundation


extension MatchMakerViewController : ItsAMatchDelegate {
    
    func itsAMatchDidChat() {
        setTabBarSelectedIndex(index: 2)
    }
    
}
