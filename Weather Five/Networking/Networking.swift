//
//  Networking.swift
//  Weather Five
//
//  Created by Vova SKR on 08/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

class Networking {
    
    func getWeatherData(lat: String, lon: String, complection: @escaping ((Result<WeatherStruct>) -> Void)) {
        var urlComponent = getBaseComponent()
        let queryItemLon = URLQueryItem(name: "lon", value: lon)
        let queryItemLat = URLQueryItem(name: "lat", value: lat)
        urlComponent.queryItems?.append(queryItemLat)
        urlComponent.queryItems?.append(queryItemLon)
        print(urlComponent)
        loadItems(with: urlComponent, completion: complection)
        
    }

    
    func getWeatherDataByCity (city: String, completion: ((Result<WeatherStruct>) -> Void)?) {
        var urlCompnents = getBaseComponent()
        let queryItemCity = URLQueryItem(name: "q", value: city)
        urlCompnents.queryItems?.append(queryItemCity)
        loadItems(with: urlCompnents, completion: completion)
    }
    
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    private let appId = "726e19c2f4bdbad2dc02c6d4c2b80971"
    private let apiHost = "api.openweathermap.org"
    private let apiPath = "/data/2.5/weather"
    
    func getBaseComponent () -> URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = apiHost
        urlComponent.path = apiPath
        let queryItemUnits = URLQueryItem(name: "units", value: "metric")
        let queryItemToken = URLQueryItem(name: "appid", value: appId)
        urlComponent.queryItems = [queryItemUnits, queryItemToken]
        
        return urlComponent
    }
    
    
    func loadItems<T: Decodable> (with components: URLComponents, completion: ((Result<T>) -> Void)?) {
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        print(request)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, responce, error) in
            guard error == nil else { return }
            guard let  jsonData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                completion?(.success(decodedData))
            } catch {
                completion?(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}

