//
//  RideRequestHandler.swift
//  Tinder-Uklon-Edition
//
//  Created by Lena Soroka on 20.02.2021.
//

import Intents

class RideRequestHandler: NSObject, INRequestRideIntentHandling {
    
    func handle(intent: INRequestRideIntent,
                completion: @escaping (INRequestRideIntentResponse) -> Void) {
      let response = INRequestRideIntentResponse(
        code: .failureRequiringAppLaunchNoServiceInArea,
        userActivity: .none)
      completion(response)
    }
    
    //MARK: Location details
    func resolvePickupLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        if let pickup = intent.pickupLocation {
            completion(.success(with: pickup))
        } else {
            completion(.needsValue())
        }
    }
    
    func resolveDropOffLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        if let dropOff = intent.dropOffLocation {
            completion(.success(with: dropOff))
        } else {
            completion(.needsValue())
        }
    }
    
    //MARK: Confirmation
    func confirm(intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        let responseCode: INRequestRideIntentResponseCode
        if let location = intent.pickupLocation?.location {
            responseCode = .ready
        } else {
            responseCode = .failureRequiringAppLaunchNoServiceInArea
        }
        let response = INRequestRideIntentResponse(code: responseCode, userActivity: nil)
        completion(response)
    }

  
}
