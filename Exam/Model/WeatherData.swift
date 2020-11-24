////
////  WeatherData.swift
////  Exam
////
//
//
//
//import Foundation
//
//struct Parser {
//
//    func parse(comp: @escaping ([Timesery]) -> ()) {
//        let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.911166&lon=10.744810")
//
//
//        URLSession.shared.dataTask(with: url!) {
//            data, response, error in
//
//            if error != nil {
//                print(error?.localizedDescription)
//                return
//            }
//            do {
//                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data!)
//                print(weatherResponse)
//                comp(weatherResponse.properties.timeseries)
//            }
//            catch {
//               print("catch: \(error)")
//            }
//        }.resume() // to start task
//    }
//}
