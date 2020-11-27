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
            return "sol" // sun.png
        case   "fair_day", "fair_night", "fair_polartwilight":
            return "lettskyet"//some_clouds.png
        case  "lightssnowshowersandthunder_day",
              "lightssnowshowersandthunder_night",
              "lightssnowshowersandthunder_polartwilight":
            return "lett snø og torden" //some_snow_thunder.png
        case    "lightsnowshowers_day", "lightsnowshowers_night", "lightsnowshowers_polartwilight":
            return "lett snø" //some_snow.png
        case   "heavyrainandthunder", "heavysnowandthunder":
            return "kraftig regn og torden" // heavy_rain_thunder.png
        case "rainandthunder":
            return "regn og torden" // rain_thunder.png
        case "heavysleetshowersandthunder_day", "heavysleetshowersandthunder_night", "heavysleetshowersandthunder_polartwilight":
            return "kraftig sludd og torden" // heavy_sleet_thunder.png
        case "heavysnow":
            return "kraftig snø" // heavy_snow.png
        case "heavyrainshowers_day","heavyrainshowers_night", "heavyrainshowers_polartwilight":
            return "kraftig regn" // heavy_rain.png
        case  "lightsleet":
            return "lett sludd" // sleet.png
        case "heavyrain":
            return "kraftig regn" // heavy_rain.png
        case "lightrainshowers_day", "lightrainshowers_night", "lightrainshowers_polartwilight":
            return "lett regn" // light_rain.png
        case "heavysleetshowers_day", "heavysleetshowers_night", "heavysleetshowers_polartwilight":
            return "kraftig sludd" // heavy_sleet.png
        case "lightsleetshowers_day", "lightsleetshowers_night", "lightsleetshowers_polartwilight":
            return "lett sludd"// light_sleet.png
        case "snow":
            return "snø" // snow.png
        case "heavyrainshowersandthunder_day", "heavyrainshowersandthunder_night", "heavyrainshowersandthunder_polartwilight":
            return "kraftig regn og torden" // heavy_rain_thunder.png
        case "snowshowers_day", "snowshowers_night", "snowshowers_polartwilight":
            return "snøbyger" // snow_weather.png
        case "fog":
            return "tåke" // fog.png
        case "snowshowersandthunder_day", "snowshowersandthunder_night", "snowshowersandthunder_polartwilight":
            return "snøbyger og torden" // snow_weather_thunder.png
        case "lightsnowandthunder":
            return "lett snø og torden"; // some_snow_thunder.png
        case "heavysleetandthunder":
            return "kraftig sludd og torden" // heavy_sleet_thunder.png
        case "lightrain":
            return "lett regn" // light_rain.png
        case "rainshowersandthunder_day", "rainshowersandthunder_night", "rainshowersandthunder_polartwilight":
            return "regnbyger og torden" // rain_weather_thunder.png
        case "rain":
            return "regn" // rain.png
        case "lightsnow":
            return "lett snø" // some_snow.png
        case "lightrainshowersandthunder_day", "lightrainshowersandthunder_night", "lightrainshowersandthunder_polartwilight":
            return "lette regnbyger og torden" // some_rain_thunder.png
        case "heavysleet":
            return "kraftig sludd" // heavy_sleet.png
        case "sleetandthunder":
            return "sludd og torden" // sleet_thunder.png
        case  "lightrainandthunder":
            return "lett regn og torden" // some_rain_thunder.png
        case "sleet":
            return "sludd" // sleet.png
        case "lightssleetshowersandthunder_day", "lightssleetshowersandthunder_night", "lightssleetshowersandthunder_polartwilight":
            return "lette sluddbyger og torden" // sleet_thunder.png
        case "lightsleetandthunder":
            return "lett sludd og torden" // sleet_thunder.png
        case "partlycloudy_day",
             "partlycloudy_night",
             "partlycloudy_polartwilight":
            return "delvis skyet" // partly_cloudy.png
        case "sleetshowersandthunder_day", "sleetshowersandthunder_night", "sleetshowersandthunder_polartwilight":
            return "sluddbyger og torden" // heavy_sleet_thunder.png
        case "rainshowers_day", "rainshowers_night", "rainshowers_polartwilight":
            return "regnbyger" // rain_weather.png
        case "snowandthunder":
            return "snø og torden" // snow_thunder.png
        case "sleetshowers_day", "sleetshowers_night", "sleetshowers_polartwilight":
            return "sluddbyger" // heavy_sleet.png
        case "cloudy":
            return "skyet" // cloudy.png
        case "heavysnowshowersandthunder_day", "heavysnowshowersandthunder_night", "heavysnowshowersandthunder_polartwilight":
            return "kraftige snøbyger og torden" // heavy_snow_thunder.png
        case "heavysnowshowers_day", "heavysnowshowers_night", "heavysnowshowers_polartwilight":
            return "kraftige snøbyger" // heavy_snow.png
        default:
            return ""
        }
    }
    
    
    
    //MARK: - SUMMARY string
    var imageString: String {
        switch condition {
        case "clearsky_day", "clearsky_night", "clearsky_polartwilight":
            return "sun" // sun.png
        case   "fair_day", "fair_night", "fair_polartwilight":
            return "some_clouds"//some_clouds.png
        case  "lightssnowshowersandthunder_day",
              "lightssnowshowersandthunder_night",
              "lightssnowshowersandthunder_polartwilight":
            return "some_snow_thunder" //some_snow_thunder.png
        case    "lightsnowshowers_day", "lightsnowshowers_night", "lightsnowshowers_polartwilight":
            return "some_snow" //some_snow.png
        case   "heavyrainandthunder", "heavysnowandthunder":
            return "kraftig regn og torden" // heavy_rain_thunder.png
        case "rainandthunder":
            return "rain_thunder" // rain_thunder.png
        case "heavysleetshowersandthunder_day", "heavysleetshowersandthunder_night", "heavysleetshowersandthunder_polartwilight":
            return "heavy_sleet_thunder" // heavy_sleet_thunder.png
        case "heavysnow":
            return "heavy_snow" // heavy_snow.png
        case "heavyrainshowers_day","heavyrainshowers_night", "heavyrainshowers_polartwilight":
            return "heavy_rain" // heavy_rain.png
        case  "lightsleet":
            return "sleet" // sleet.png
        case "heavyrain":
            return "heavy_rain" // heavy_rain.png
        case "lightrainshowers_day", "lightrainshowers_night", "lightrainshowers_polartwilight":
            return "light_rain" // light_rain.png
        case "heavysleetshowers_day", "heavysleetshowers_night", "heavysleetshowers_polartwilight":
            return "heavy_sleet" // heavy_sleet.png
        case "lightsleetshowers_day", "lightsleetshowers_night", "lightsleetshowers_polartwilight":
            return "light_sleet"// light_sleet.png
        case "snow":
            return "snow" // snow.png
        case "heavyrainshowersandthunder_day", "heavyrainshowersandthunder_night", "heavyrainshowersandthunder_polartwilight":
            return "heavy_rain_thunder" // heavy_rain_thunder.png
        case "snowshowers_day", "snowshowers_night", "snowshowers_polartwilight":
            return "snow_weather" // snow_weather.png
        case "fog":
            return "fog" // fog.png
        case "snowshowersandthunder_day", "snowshowersandthunder_night", "snowshowersandthunder_polartwilight":
            return "snow_weather_thunder" // snow_weather_thunder.png
        case "lightsnowandthunder":
            return "some_snow_thunder"; // some_snow_thunder.png
        case "heavysleetandthunder":
            return "heavy_sleet_thunder" // heavy_sleet_thunder.png
        case "lightrain":
            return "light_rain" // light_rain.png
        case "rainshowersandthunder_day", "rainshowersandthunder_night", "rainshowersandthunder_polartwilight":
            return "rain_weather_thunder" // rain_weather_thunder.png
        case "rain":
            return "rain" // rain.png
        case "lightsnow":
            return "some_snow" // some_snow.png
        case "lightrainshowersandthunder_day", "lightrainshowersandthunder_night", "lightrainshowersandthunder_polartwilight":
            return "some_rain_thunder" // some_rain_thunder.png
        case "heavysleet":
            return "heavy_sleet" // heavy_sleet.png
        case "sleetandthunder":
            return "sleet_thunder" // sleet_thunder.png
        case  "lightrainandthunder":
            return "some_rain_thunder" // some_rain_thunder.png
        case "sleet":
            return "sleet" // sleet.png
        case "lightssleetshowersandthunder_day", "lightssleetshowersandthunder_night", "lightssleetshowersandthunder_polartwilight":
            return "sleet_thunder" // sleet_thunder.png
        case "lightsleetandthunder":
            return "sleet_thunder" // sleet_thunder.png
        case "partlycloudy_day",
             "partlycloudy_night",
             "partlycloudy_polartwilight":
            return "partly_cloudy" // partly_cloudy.png
        case "sleetshowersandthunder_day", "sleetshowersandthunder_night", "sleetshowersandthunder_polartwilight":
            return "heavy_sleet_thunder" // heavy_sleet_thunder.png
        case "rainshowers_day", "rainshowers_night", "rainshowers_polartwilight":
            return "rain_weather" // rain_weather.png
        case "snowandthunder":
            return "snow_thunder" // snow_thunder.png
        case "sleetshowers_day", "sleetshowers_night", "sleetshowers_polartwilight":
            return "heavy_sleet" // heavy_sleet.png
        case "cloudy":
            return "cloudy" // cloudy.png
        case "heavysnowshowersandthunder_day", "heavysnowshowersandthunder_night", "heavysnowshowersandthunder_polartwilight":
            return "heavy_snow_thunder" // heavy_snow_thunder.png
        case "heavysnowshowers_day", "heavysnowshowers_night", "heavysnowshowers_polartwilight":
            return "heavy_snow" // heavy_snow.png
        default:
            return ""
        }
    }
    
 
    
}
