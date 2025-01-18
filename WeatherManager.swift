//
//  WeatherManager.swift
//  Clima
//
//  Created by Tarek Ahmed on 08/10/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherDataDelegate{
    func didUpdateWeather(weather: WeatherModel)
}



struct WeatherManager{
    
    var delegate: WeatherDataDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=fc3fa2b59f725a9a577589a8063c9ba3"
    
    func fetchWeather(cityName: String){
        
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(URLstring: URLString)
        
    }
    
    func performRequest(URLstring: String){
        
        
        if  let url = URL(string: URLstring){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print("Error: \(error!)")
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(cityname: name, temperature: temp, conditionId : id)
            return weather
        } catch {
            print("Error: \(error)")
            return nil
        }
        
    }
   
    
}


// Quick overview on this page 1st of all we make a structure named it weather manager and we took the API that is named here weather url then we create a function named the Fitch weather this will take the weather URL and add to it the queries I need to edit like city name or any other parameters until here we have a ready URL with the queries parameters API key then we make a function named perform request. This will make the request to the server first step inside the function we create a URL and post the url string to it then I create a urlsession and store it in a constant named session now I have the URL and I created a session. We must give the decision a task to perform it then I create a constant name the task and and then I give it the task I passed to it they are L and call The function. Completion handler. The function complete and handler is responsible to take the response from the web server and fetch it and see if there's an error it print the error and if the data is safe, it convert the data to string to let the app use it.m
