import Foundation


class Auth {
    
    
    // Var's
    public static let shared = Auth()
    private var id: Int
    private var name: String
    private var anonymous: Bool
    private var token: String
    
    
    // Keys
    private enum Key {
        static let id = "Auth.Id"
        static let name = "Auth.Name"
        static let anonymous = "Auth.Anonymous"
        static let token = "Auth.Token"
    }
    
    
    // Construct
    init() {
        id = 0
        name = ""
        anonymous = true
        token = ""
    }
    convenience init(dto: AuthLoginResponseDTO) {
        self.init()
        
        self.id << dto.id
        self.name << dto.name
        self.anonymous << dto.anonymous
        self.token << dto.token
    }
    
    
    // Handler save
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(self.id, forKey: Key.id)
        defaults.set(self.name, forKey: Key.name)
        defaults.set(self.anonymous, forKey: Key.anonymous)
        defaults.set(self.token, forKey: Key.token)
        defaults.synchronize()
    }
    
    
    // Handler load
    func load() {
        let defaults = UserDefaults.standard
        self.id = defaults.integer(forKey: Key.id)
        self.name = defaults.string(forKey: Key.name) ?? ""
        self.anonymous = defaults.bool(forKey: Key.anonymous)
        self.token = defaults.string(forKey: Key.token) ?? ""
    }
    
    
    // Handler clear
    func clear() {
        id = 0
        name = ""
        anonymous = true
        token = ""
        save()
    }
    
    
    // Get's
    func getId() -> Int {
        return self.id
    }
    func getName() -> String {
        return self.name
    }
    func getAnonymous() -> Bool {
        return self.anonymous
    }
    func getToken() -> String {
        return self.token
    }
    
    
    // Set's
    func setAnonymous(_ anonymous: Bool) {
        self.anonymous = anonymous
    }
    
    
    // Is Auth User
    func isAuth() -> Bool {
        return !self.token.isEmpty
    }
    
    
}
