//
//  IntentHandler.swift
//  RideRequestExtension
//
//  Created by Lena Soroka on 20.02.2021.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        if intent is INRequestRideIntent {
            return RideRequestHandler()
        }
        return .none
    }

}
