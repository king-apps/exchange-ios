

// Generic type for String and optional String
func << <T>(left: inout String, right: T) {
    if let right = right as? String {
        left = right
    }
}
func << <T>(left: inout String?, right: T) {
    if let right = right as? String {
        left = right
    }
}


// Generic type for Int and optional Int
func << <T>(left: inout Int?, right: T) {
    if let right = right as? Int {
        left = right
    }
}
func << <T>(left: inout Int, right: T) {
    if let right = right as? Int {
        left = right
    }
}


// Generic type for Float and optional Float
func << <T>(left: inout Float?, right: T) {
    if let right = right as? Float {
        left = right
    }
}
func << <T>(left: inout Float, right: T) {
    if let right = right as? Float {
        left = right
    }
}


// Generic type for Double and optional Double
func << <T>(left: inout Double?, right: T) {
    if let right = right as? Double {
        left = right
    }
}
func << <T>(left: inout Double, right: T) {
    if let right = right as? Double {
        left = right
    }
}


// Generic type for Bool and optional Bool
func << <T>(left: inout Bool?, right: T) {
    if let right = right as? Bool {
        left = right
    }
}
func << <T>(left: inout Bool, right: T) {
    if let right = right as? Bool {
        left = right
    }
}


// Generic type for String:Any and optional String:Any
func << <T>(left: inout [String:Any], right: T) {
    if let right = right as? [String:Any] {
        left = right
    }
}
func << <T>(left: inout [String:Any]?, right: T) {
    if let right = right as? [String:Any] {
        left = right
    }
}


// Generic type for String:Any and optional String:Any
func << <T>(left: inout [[String:Any]], right: T) {
    if let right = right as? [[String:Any]] {
        left = right
    }
}
func << <T>(left: inout [[String:Any]]?, right: T) {
    if let right = right as? [[String:Any]] {
        left = right
    }
}


