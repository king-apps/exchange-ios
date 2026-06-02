import Foundation


enum UserEndpoint {
    
    static func localization(request: UserLocalizationRequestDTO) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/localization"
    }
    static func delete() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/delete"
    }
    static func fcmToken() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/fcm-token"
    }
    static func avatar() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/profile/avatar"
    }
    static func update() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/profile"
    }
    static func profile() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/profile"
    }
    static func emailValidationSend() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/email-validation/send"
    }
    static func emailValidationValidate() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/email-validation/validate"
    }
    
    static func linkEmailSend() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/link-email/send"
    }
    static func linkEmailValidate() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/user/link-email/validate"
    }
}
