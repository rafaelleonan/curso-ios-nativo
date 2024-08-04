//
//  API.swift
//  AppRequestRestApi
//
//  Created by Davi Orzechowski on 22/05/24.
//

import Foundation

class API:NSObject {
    @objc
    func buscarElemento(completion: @escaping (_ jsonData:NSMutableDictionary?)->Void){
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        var request = URLRequest(url: URL(string: url)!,cachePolicy: .reloadIgnoringLocalCacheData,timeoutInterval: 60.0)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            data,response,error in
            if(data != nil){
                let result = NSMutableDictionary()
                let res = response as! HTTPURLResponse
                print(res.statusCode)
                do{
                    let dataJson = try JSONSerialization.jsonObject(with: data!)
                    result["data"] = dataJson
                    result["statusCode"] = String.init(format: "%li", res.statusCode)
                } catch {
                    result["statusCode"] = "404"
                }
                completion(result)
            } else {
                let result = NSMutableDictionary()
                result["statusCode"] = "404"
                completion(result)
            }
        })
        task.resume()
    }
}
