//
//  BluetoothKit
//
//  Copyright (c) 2015 Rasmus Taulborg Hummelmose - https://github.com/rasmusth
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import CoreBluetooth

/**
    Class that represents a configuration used when starting a BKCentral object.
*/
public class BKConfiguration {

    // MARK: Properties

    public var services: [BKService] = []

    /// Data used to indicate if needed that no more data is coming when communicating.
    public var endOfDataMark: Data

    /// Data used to indicate that a transfer was cancellen when communicating.
    public var dataCancelledMark: Data

    internal var serviceUUIDs: [CBUUID] {
        let serviceUUIDs = services.map { $0.dataServiceUUID }
        return serviceUUIDs
    }

    internal var advertisedServicesUUIDs: [CBUUID]

    // MARK: Initialization

    public init(services: [BKService], advertisedServicesUUIDs: [CBUUID]) {
        self.advertisedServicesUUIDs = advertisedServicesUUIDs
        self.services = services
        endOfDataMark = "EOD".data(using: String.Encoding.utf8)!
        dataCancelledMark = "COD".data(using: String.Encoding.utf8)!
    }

    // MARK Functions

    internal func characteristicUUIDsForServiceUUID(_ serviceUUID: CBUUID) -> [CBUUID] {
        if let service = services.filter({ $0.dataServiceUUID == serviceUUID }).first {
          return [service.readDataServiceCharacteristicUUID, service.writeDataServiceCharacteristicUUID]
        }
        return []
    }

}
