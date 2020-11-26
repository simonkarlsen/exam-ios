//
//  WeatherManager.swift
//  Exam
//


//

//"https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.911166&lon=10.744810"

import Foundation
import CoreLocation

//let urlString = "\(weatherURL)lat=\(latitude)&lon=\(longitude)"

enum WeatherError: Error {
    case noData
    case processError
}

struct WeatherManager {
    let weatherURL: URL
    let urlBase = "https://api.met.no/weatherapi/locationforecast/2.0/compact?"
    
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        print("init")
        let weatherUrlString = "\(urlBase)lat=\(latitude)&lon=\(longitude)"
        guard let weatherURL = URL(string: weatherUrlString) else {
            fatalError()
        }
        self.weatherURL = weatherURL
//        print("self.weatherURL")
        print(self.weatherURL)
    }
  
    func getWeather (completion: @escaping(Result<[WeatherModel], WeatherError>) -> Void) {
        print("getWeather")
        let dataTask = URLSession.shared.dataTask(with: weatherURL) {
            data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noData))
             
                return
            }
            do {
                let decoder = JSONDecoder()
//                print("before try")
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                
//                print("before timeS")
                let weather = weatherResponse
                
                let instantTemp: String = String(weather.properties.timeseries[0].data.instant.details.airTemperature)
                
                let instantUnits = weather.properties.meta.units.airTemperature
            
                var modelArr = [WeatherModel]()
                
                //MARK: - Instant model
                let weatherModelInstant = WeatherModel(condition: nil, temperature: instantTemp, rain: nil, rainUnits: nil, tempUnits: instantUnits)
                modelArr.append(weatherModelInstant)
                
                
                //MARK: - 1 Hour model
                let rain1Hour: String? = weather.properties.timeseries[0].data.next1_Hours?.details.precipitationAmount.description
                
                let summary1Hour: String? = weather.properties.timeseries[0].data.next1_Hours?.summary.symbolCode
                
                let units1hour: String? = weather.properties.meta.units.precipitationAmount
                
                let weatherModel1hours = WeatherModel(condition: summary1Hour, temperature: nil, rain: rain1Hour, rainUnits: units1hour, tempUnits: nil)
                modelArr.append(weatherModel1hours)
                
                //MARK: - 6 hour model
                let rain6Hour: String? = weather.properties.timeseries[0].data.next6_Hours?.details.precipitationAmount.description
                
                let summary6Hour: String? = weather.properties.timeseries[0].data.next6_Hours?.summary.symbolCode
                
                let units6hour: String? = weather.properties.meta.units.precipitationAmount
                
                let weatherModel6hours = WeatherModel(condition: summary6Hour, temperature: nil, rain: rain6Hour, rainUnits: units6hour, tempUnits: nil)
                modelArr.append(weatherModel6hours)
                
                
                //MARK: - 12 hour model
                
                let summary12Hour: String? = weather.properties.timeseries[0].data.next12_Hours?.summary.symbolCode
                
                let weatherModel12hours = WeatherModel(condition: summary12Hour, temperature: nil, rain: nil, rainUnits: nil, tempUnits: nil)
                modelArr.append(weatherModel12hours)
                
                completion(.success(modelArr))
                print("success")
            }
            catch {
                completion(.failure(.processError))
                print("failure")
            }
            
        }
        dataTask.resume() //start
    }

}

