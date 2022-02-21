
import Foundation
import Alamofire
import SwiftyJSON

class Networking{
  static let instance = Networking()
  
  func getAPICall(url: String, completionHandler: @escaping (_ Response:JSON,_ Error:String?, _ StatusCode: Int) -> ()){
    Alamofire.request(url , method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON { (response) in
      debugPrint(response)
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")// response serialization result
        let statusCode = response.response?.statusCode
        switch response.result {
        case .success(_):
            guard let data = response.data else {return}
            print(data)
            completionHandler(JSON(data),nil, statusCode ?? -1)
        case .failure(let error): completionHandler(JSON(error),error.localizedDescription, statusCode ?? -1)
        }
    }
  }
}
