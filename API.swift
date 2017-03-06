//  API.swift
//
//  A URLSession Wrapper written in swift to make life just a little easier
//  to access http apis
//
//  Created by Eliel on 2017/4/3.
//  Copyright © 2016 Eliel Amora All rights reserved.
//

import Foundation

/// A simple wrapper for swift URLSession and the like to call on RESTful APIs
/// supports the main RESTFUL CRUD operations (GET, POST, PUT, DELETE)
class API {
    var baseURI: String
    init (_ baseURI: String){
        self.baseURI = baseURI
        //assert "/" suffix to uri
        if !self.baseURI.hasSuffix("/") {
            self.baseURI += "/"
        }
    }
    private static let allowedHttpMethods: Set =
        [HTTPMethod.GET, HTTPMethod.POST, HTTPMethod.PUT, HTTPMethod.DELETE]
    // todo: add more methods
    public class HTTPMethod{
        static let GET = "GET"
        static let POST = "POST"
        static let PUT = "PUT"
        static let DELETE = "DELETE"
    }

    /// provides all the facilities to call an HTTP API
    ///
    /// - Parameters:
    ///   - url: a url object of the api endpoint
    ///   - method: String of http method e.g. "GET"
    ///   - headers: `[String: String]`
    ///   - data: byte array passed into the body of the request
    ///   - callback: callback to run async after the request is recieved
    public static func call (
        _ url: URL,
        method: String,
        headers: [String : String],
        data: Data?,
        failure: @escaping () -> () = {},
        success: @escaping (Data, HTTPURLResponse) -> ())
    -> Void
    {
        var request = URLRequest(url: url)
        assert(API.allowedHttpMethods.contains(method))
        request.httpMethod = method
        // add headers
        for (header, value) in headers {
            request.addValue(value, forHTTPHeaderField: header)
        }
        request.httpBody = data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { // check for fundamental networking error
                //print("error=\(error)")
                failure()
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                //
                //to convert resonse as a string use:
                //String(data: data, encoding: .utf8)
                //get status code: httpStatus.statusCode and use case statement
                    //debug("Status Code is \(httpResponse.statusCode)")
                    //debug("response = \(responseString)")
                print("doing callback for the method")
                success(data, httpResponse)
            }
        }
        task.resume()
    }

    private func encode (_ params: [String: String]) -> [String: String]{
        let unencodedCharacterSet = CharacterSet(charactersIn: "-_.~").union(.alphanumerics)
        var encodedParams : [String: String] = [:]
        for (key, value) in params{
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: unencodedCharacterSet)!
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: unencodedCharacterSet)!
            encodedParams[encodedKey] = encodedValue
        }
        return encodedParams
    }

    private func paramString(_ params: [String: String]) -> String {
        var postString = ""
        var first = true
        for (key, value) in params{
            if first {
                postString = key + "=" + value
                first = false
            }else{
                postString = postString + "&" + key + "=" + value
            }
        }
        return postString
    }
    private func postString(_ params: [String: String]) -> String {
        return paramString(encode(params))
    }
    private func queryString(_ params: [String: String]) -> String {
        var queryString = params.count > 0 ? "?" : ""
        queryString += paramString(encode(params))
        return queryString
    }

    /** public interface */

    /// POST request
    ///
    /// - Parameters:
    ///   - endpoint: String of the url endpoint * note: it cannot start with "/"
    ///   - headers: Map of strings for header name and values
    ///   - params: post body parameters as Map of Strings
    ///   - callback: action after request returns successfully
    ///   - success: success callback
    ///   - failure: failure callback
    public func post (_ endpoint: String, headers: [String: String] = [:],
                      params: [String: String] = [:],
                      failure: @escaping () -> () = {},
                      success: @escaping (Data, HTTPURLResponse) -> ())
    {
        let body = postString(params)
        print(body)
        if let url = URL(string: self.baseURI + endpoint){
            API.call(url,
                     method: HTTPMethod.POST,
                     headers: headers,
                     data: body.data(using: .utf8),
                     failure: failure,
                     success: success)
        }
    }
    /// PUT request
    ///
    /// - Parameters:
    ///   - endpoint: String of the url endpoint * note: it cannot start with "/"
    ///   - headers: Map of strings for header name and values
    ///   - params: post body parameters as Map of Strings
    ///   - callback: action after request returns successfully
    ///   - success: success callback
    ///   - failure: failure callback
    public func put (_ endpoint: String, headers: [String: String] = [:],
                      params: [String: String] = [:],
                      failure: @escaping () -> () = {},
                      success: @escaping (Data, HTTPURLResponse) -> ())
    {
        let body = postString(params)
        print(body)
        if let url = URL(string: self.baseURI + endpoint){
            API.call(url,
                     method: HTTPMethod.PUT,
                     headers: headers,
                     data: body.data(using: .utf8),
                     failure: failure,
                     success: success)
        }
    }

    /// GET Request to API
    ///
    /// - Parameters:
    ///   - endpoint: String of enpoint * note: it cannot start with "/"
    ///   - headers: Map of strings for header name and values
    ///   - params: post body parameters as Map of Strings
    ///   - success: success callback
    ///   - failure: failure callback
    public func get (_ endpoint: String, headers: [String: String] = [:],
                     params: [String: String] = [:],
                     failure: @escaping ()->() = {},
                     success: @escaping (Data, HTTPURLResponse) -> ()){
        let qs = queryString(params)
        print(qs)
        if let url = URL(string: self.baseURI + endpoint){
            API.call(url,
                     method: HTTPMethod.GET,
                     headers: headers,
                     data: nil,
                     failure: failure,
                     success: success)
        }
    }
    /// DELETE Request to API
    ///
    /// - Parameters:
    ///   - endpoint: String of enpoint * note: it cannot start with "/"
    ///   - headers: Map of strings for header name and values
    ///   - params: post body parameters as Map of Strings
    ///   - success: success callback
    ///   - failure: failure callback
    public func delete (_ endpoint: String, headers: [String: String] = [:],
                     params: [String: String] = [:],
                     failure: @escaping ()->() = {},
                     success: @escaping (Data, HTTPURLResponse) -> ()){
        let qs = queryString(params)
        print(qs)
        if let url = URL(string: self.baseURI + endpoint){
            API.call(url,
                     method: HTTPMethod.DELETE,
                     headers: headers,
                     data: nil,
                     failure: failure,
                     success: success)
        }
    }
}
