//
//  WeatherModel.swift
//  Exam
//


import Foundation

struct WeatherModel {
    // stored property
    let condition: String?
    let temperature: String?
    let rain: String?
    let rainUnits: String?
    let tempUnits: String?


    //MARK: - SUMMARY string
    var summary: String {
        switch condition {
        case "clearsky_day", "clearsky_night", "clearsky_polartwilight":
            return "sol"
        case   "fair_day", "fair_night", "fair_polartwilight":
            return "lettskyet"
        case  "lightssnowshowersandthunder_day",
              "lightssnowshowersandthunder_night",
              "lightssnowshowersandthunder_polartwilight":
            return "lett snø og toden"
        case    "lightsnowshowers_day", "lightsnowshowers_night", "lightsnowshowers_polartwilight":
            return "lett snø"
        case   "heavyrainandthunder", "heavysnowandthunder":
            return "kraftig regn og torden"
        case "rainandthunder":
            return "regn og torden"
        case "heavysleetshowersandthunder_day", "heavysleetshowersandthunder_night", "heavysleetshowersandthunder_polartwilight":
            return "kraftig sludd og torden"
        case "heavysnow":
            return "kraftig snø"
        case "heavyrainshowers_day","heavyrainshowers_night", "heavyrainshowers_polartwilight":
            return "kraftig regn"
        case  "lightsleet":
            return "lett sludd"
        case "heavyrain":
            return "kraftig regn"
        case "lightrainshowers_day", "lightrainshowers_night", "lightrainshowers_polartwilight":
            return "lett regn"
        case "heavysleetshowers_day", "heavysleetshowers_night", "heavysleetshowers_polartwilight":
            return "kraftig sludd"
        case "lightsleetshowers_day", "lightsleetshowers_night", "lightsleetshowers_polartwilight":
            return "lett sludd"
        case "snow":
            return "snø"
        case "heavyrainshowersandthunder_day", "heavyrainshowersandthunder_night", "heavyrainshowersandthunder_polartwilight":
            return "kraftig regn og torden"
        case "snowshowers_day", "snowshowers_night", "snowshowers_polartwilight":
            return "snøbyger"
        case "fog":
            return "tåke"
        case "snowshowersandthunder_day", "snowshowersandthunder_night", "snowshowersandthunder_polartwilight":
            return "snøbyger og torden"
        case "lightsnowandthunder":
            return "lett snø og torden";
        case "heavysleetandthunder":
            return "kraftig sludd og torden"
        case "lightrain":
            return "lett regn"
        case "rainshowersandthunder_day", "rainshowersandthunder_night", "rainshowersandthunder_polartwilight":
            return "regnbyger og torden"
        case "rain":
            return "regn"
        case "lightsnow":
            return "lett snø"
        case "lightrainshowersandthunder_day", "lightrainshowersandthunder_night", "lightrainshowersandthunder_polartwilight":
            return "lette regnbyger og torden"
        case "heavysleet":
            return "kraftig sludd"
        case "sleetandthunder":
            return "sludd og torden"
        case  "lightrainandthunder":
            return "lett regn og torden"
        case "sleet":
            return "sludd"
        case "lightssleetshowersandthunder_day", "lightssleetshowersandthunder_night", "lightssleetshowersandthunder_polartwilight":
            return "lette sluddbyger og torden"
        case "lightsleetandthunder":
            return "lett sludd og torden"
        case "partlycloudy_day",
             "partlycloudy_night",
             "partlycloudy_polartwilight":
            return "delvis skyet"
        case "sleetshowersandthunder_day", "sleetshowersandthunder_night", "sleetshowersandthunder_polartwilight":
            return "sluddbyger og torden"
        case "rainshowers_day", "rainshowers_night", "rainshowers_polartwilight":
            return "regnbyger"
        case "snowandthunder":
            return "snø og torden"
        case "sleetshowers_day", "sleetshowers_night", "sleetshowers_polartwilight":
            return "sluddbyger"
        case "cloudy":
            return "skyet"
        case "heavysnowshowersandthunder_day", "heavysnowshowersandthunder_night", "heavysnowshowersandthunder_polartwilight":
            return "kraftige snøbyger og torden"
        case "heavysnowshowers_day", "heavysnowshowers_night", "heavysnowshowers_polartwilight":
            return "kraftige snøbyger"
        default:
            return ""
        }
    }
    
    
 
    
}
