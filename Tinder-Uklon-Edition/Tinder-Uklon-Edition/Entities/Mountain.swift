//
//  Mountain.swift
//  ARCoreLocationExample
//
//  Created by Skyler Smith on 2019-01-02.
//  Copyright © 2019 Freshworks Studio Inc. All rights reserved.
//

import Foundation

struct Mountain {
    let id: String = UUID().uuidString
    
    let latitude: Double
    let longitude: Double
    let altitude: Double
    
    let name: String
}

struct SimpleData_Mountains {
    static let mountains: [Mountain] = [
        Mountain(latitude: 27.98806, longitude: 86.92528, altitude: 8848, name: "Mount Everest"),
        Mountain(latitude: 35.88139, longitude: 76.51333, altitude: 8611, name: "K2"),
        Mountain(latitude: 27.70333, longitude: 88.1475, altitude: 8586, name: "Kangchenjunga"),
        Mountain(latitude: 63.06900, longitude: -151.0063, altitude: 6191, name: "Mount McKinley"),
        Mountain(latitude: 60.56710, longitude: -140.4055, altitude: 5959, name: "Mount Logan")
    ]
}

struct VictoriaLandmark {
    let id: String = UUID().uuidString
    
    let latitude: Double
    let longitude: Double
    
    let name: String
    let details: String?
}

struct VictoriaData_Landmarks {//48.504916774648024, 35.08895341534381
    //48.464717, 35.046183
    //48.464717, 35.046183
    //48.505107, 35.088031
    //48.505019, 35.088811
    
    static var landmarks: [VictoriaLandmark] = [
        VictoriaLandmark(latitude:  48.505164, longitude: 35.088070, name: "Your car", details: "Тут могла быть ваша реклама")
        
    ]
}
