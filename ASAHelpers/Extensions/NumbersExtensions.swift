//
//  IntExtension.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 5/2/17.
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

public extension Double {

    var roundedString: String {
        return String(format:"%.2f", self)
    }

    var distanceInMiles: Double {

        var distanceKilometers = Measurement(value: self, unit: UnitLength.kilometers)

        distanceKilometers.convert(to: UnitLength.miles)
        return distanceKilometers.value
    }

    var weightInPounds: Double {

        var weightKilograms = Measurement(value: self, unit: UnitMass.kilograms)

        weightKilograms.convert(to: UnitMass.pounds)
        return weightKilograms.value
    }
}

extension Int {
    public var isEven: Bool {
        return self % 2 == 0
    }
}
