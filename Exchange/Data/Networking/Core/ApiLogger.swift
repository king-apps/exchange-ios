import Foundation
import Alamofire


final class ApiLogger: EventMonitor {

    let queue = DispatchQueue(label: "api.logger")

    func request(_ request: Request, didCreateURLRequest urlRequest: URLRequest) {
        let method = urlRequest.httpMethod ?? "UNKNOWN"
        let url = urlRequest.url?.absoluteString ?? "UNKNOWN_URL"
        let headers = urlRequest.headers.dictionary
        let body = bodyString(from: urlRequest.httpBody)

        print("➡️ REQUEST: \(method) \(url)")
        print("➡️ HEADERS: \(headers)")
        print("➡️ BODY: \(body)")
    }

    func request(_ request: Request, didCompleteTask task: URLSessionTask, with error: AFError?) {
        let method = task.originalRequest?.httpMethod ?? task.currentRequest?.httpMethod ?? "UNKNOWN"
        let url = task.originalRequest?.url?.absoluteString ?? task.currentRequest?.url?.absoluteString ?? "UNKNOWN_URL"
        let statusCode = (task.response as? HTTPURLResponse)?.statusCode ?? -1

        print("⬅️ RESPONSE: \(method) \(url) (\(statusCode))")

        if let error {
            print("⬅️ ERROR: \(error.localizedDescription)")
        }
    }

    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        logBody(response.data)
    }

    func request<Value: Sendable>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        logBody(response.data)
    }

    private func bodyString(from data: Data?) -> String {
        guard let data, !data.isEmpty else {
            return "empty"
        }

        return responseString(from: data)
    }

    private func responseString(from data: Data) -> String {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            return prettyString
        }

        return String(data: data, encoding: .utf8) ?? "<non-utf8-body>"
    }

    private func logBody(_ data: Data?) {
        if let data {
            print("⬅️ BODY: \(responseString(from: data))")
        } else {
            print("⬅️ BODY: empty")
        }
    }
}
