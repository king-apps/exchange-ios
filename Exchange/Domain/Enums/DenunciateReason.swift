import Foundation


enum DenunciateReason: String {
    case block = "Bloquear usuário"
    case image = "Foto inadequada"
    case spam = "Parece spam"
    case other = "Outro"
    case none = "Nenhum"
    
    static var Block: DenunciateReason { .block }
    static var Image: DenunciateReason { .image }
    static var Spam: DenunciateReason { .spam }
    static var Other: DenunciateReason { .other }
    static var None: DenunciateReason { .none }
}
