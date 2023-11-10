//
//  WeatherView.swift
//  SeniorHealth
//
//  Created by 서은서 on 11/10/23.
//
import Foundation
import Alamofire

class DataManager: ObservableObject {
    @Published var weatherData: WeatherData?

    init() {
        fetchData()
    }

    func fetchData() {
        // 현재 날짜를 "yyyyMMdd" 형식으로 문자열로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDate = dateFormatter.string(from: Date())

        // 현재 시간을 "HHmm" 형식으로 문자열로 변환
        dateFormatter.dateFormat = "HHmm"
        let currentTime = dateFormatter.string(from: Date())

        // API 요청을 보낼 URL 및 요청 변수 설정
        let serviceKey = "ga%2F64xeeGEu9XluNODa2%2BKvtPcSTUjV4otmdyLFkB%2BQGIgfoXPVjTJpB4ctc6vIA5x3XoGKMOK0a0wipNk2Wyw%3D%3D"
        let pageNo = 1
        let numberOfRows = 10
        let dataType = "JSON"
        let baseDate = currentDate
        let baseTime = currentTime
        let nx = 89 // 대구 시청 위치 동안동
        let ny = 91 // 대구 시청 위치 동안동

        let baseUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
        let parameters: [String: Any] = [
            "ServiceKey": serviceKey,
            "pageNo": pageNo,
            "numOfRows": numberOfRows,
            "dataType": dataType,
            "base_date": baseDate,
            "base_time": baseTime,
            "nx": nx,
            "ny": ny
        ]

        // Alamofire를 사용하여 API 요청 보내기
        AF.request(baseUrl, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    if let json = data as? [String: Any] {
                        // API 응답 데이터를 파싱하고 필요한 정보를 추출하여 WeatherData로 업데이트
                        if let weatherData = self.parseWeatherData(from: json) {
                            self.weatherData = weatherData
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }

    // API 응답 데이터를 파싱하여 WeatherData 객체로 반환
    func parseWeatherData(from json: [String: Any]) -> WeatherData? {
        // 필요한 정보를 파싱하여 WeatherData 객체를 생성하고 반환하는 코드를 작성하세요.
        return nil
    }
}

struct WeatherData {
    var temperature: Int = 0
    var minTemperature: Int = 0
    var maxTemperature: Int = 0
    var precipitationProbability: Int = 0
    var precipitationType: String = ""
    var humidity: Int = 0
    var skyStatus: String = ""
}


//import Foundation
//import Alamofire
//
//import SwiftUI
//
//struct WeatherView: View {
//    
//    @State private var weatherData: WeatherData? = nil
//
//    var body: some View {
//        VStack {
//            if let weatherData = weatherData {
//                WeatherView(weatherData: weatherData)
//            } else {
//                Text("Loading...")
//                    .onAppear {
//                        fetchData()
//                    }
//            }
//        }
//    }
//    
//    func fetchData() {
//        // Alamofire로 API 요청을 보내고 응답을 처리한 후, JSON 데이터를 파싱합니다.
//        AF.request(baseUrl, parameters: parameters)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let data):
//                    if let json = data as? [String: Any] {
//                        if let response = json["response"] as? [String: Any],
//                            let body = response["body"] as? [String: Any],
//                            let items = body["items"] as? [String: Any] {
//                            
//                            // 이제 items에는 예보 데이터가 들어 있습니다. 필요한 정보를 추출합니다.
//                            if let itemArray = items["item"] as? [[String: String]] {
//                                for item in itemArray {
//                                    if let category = item["category"],
//                                       let fcstValue = item["fcstValue"],
//                                       let fcstDate = item["fcstDate"],
//                                       let fcstTime = item["fcstTime"] {
//                                        // 필요한 정보를 배열에 추가합니다.
//                                        if category == "TMP" {
//                                            weatherData?.temperature = Int(fcstValue) ?? 0
//                                        } else if category == "TMN" {
//                                            weatherData?.minTemperature = Int(fcstValue) ?? 0
//                                        } else if category == "TMX" {
//                                            weatherData?.maxTemperature = Int(fcstValue) ?? 0
//                                        } else if category == "POP" {
//                                            weatherData?.precipitationProbability = Int(fcstValue) ?? 0
//                                        } else if category == "PTY" {
//                                            weatherData?.precipitationType = fcstValue
//                                        } else if category == "REH" {
//                                            weatherData?.humidity = Int(fcstValue) ?? 0
//                                        } else if category == "SKY" {
//                                            weatherData?.skyStatus = fcstValue
//                                        }
//                                    }
//                                }
//                                // 데이터를 업데이트하여 SwiftUI 뷰를 리로드합니다.
//                                self.weatherData = weatherData
//                            }
//                        }
//                    }
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//    }
//}
//
//    
    
    
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyyMMdd"
//let currentDate = DateFormatter.string(from: Date())
//
//dateFormatter.dateFormat = "HHmm"
//let currentTime = DateFormatter.string(from: Date())
//
//let serviceKey = "ga%2F64xeeGEu9XluNODa2%2BKvtPcSTUjV4otmdyLFkB%2BQGIgfoXPVjTJpB4ctc6vIA5x3XoGKMOK0a0wipNk2Wyw%3D%3D"
//let pageNo = 1
//let numberOfRows = 10
//let dataType = "jSON"
//let baseDate = currentDate
//let baseTime = currentTime
//let nx = 89 // 대구 시청 위치 동안동
//let ny = 91 // 대구 시청 위치 동안동
//
//let baseUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
//let parameters: [String: Any] = [
//    "ServiceKey": serviceKey,
//    "pageNo": pageNo,
//    "numOfRows": numberOfRows,
//    "base_date": baseDate,
//    "base_time": baseTime,
//    "nx": nx,
//    "ny": ny
//]

//// Alamofire로 API 요청을 보내고 응답을 처리한 후, JSON 데이터를 파싱합니다.
//AF.request(baseUrl, parameters: parameters)
//    .responseJSON { response in
//        switch response.result {
//        case .success(let data):
//            if let json = data as? [String: Any] {
//                if let response = json["response"] as? [String: Any],
//                   let body = response["body"] as? [String: Any],
//                   let items = body["items"] as? [String: Any] {
//                   
//                    // 이제 items에는 예보 데이터가 들어 있습니다. 여기서 필요한 정보를 추출합니다.
//                    if let itemArray = items["item"] as? [[String: String]] {
//                        var fcstData = [String]()  // fcstDate, fcstTime, fcstValue 값을 저장할 배열
//
//                        for item in itemArray {
//                            if let category = item["category"],
//                               let fcstValue = item["fcstValue"],
//                               let fcstDate = item["fcstDate"],
//                               let fcstTime = item["fcstTime"] {
//                                // 필요한 정보를 배열에 추가합니다.
//                                fcstData.append("fcstDate: \(fcstDate), fcstTime: \(fcstTime), fcstValue: \(fcstValue)")
//                            }
//                        }
//
//                        // fcstData 배열에는 필요한 정보가 포함됩니다.
//                        for data in fcstData {
//                            print(data)
//                        }
//                    }
//                }
//            }
//        case .failure(let error):
//            print("Error: \(error)")
//        }
//    }
