//
//  RandNumberFunctions.swift
//  iOSUnitTestSwift
//
//  Created by Huy Do on 3/24/20.
//  Copyright © 2020 Kryptowire. All rights reserved.
//

import Foundation

enum RandNumberTestError: Error {
    case randomGenerator(String)
}

func RandNumberTest() -> String{
    var result = "Random Number Test:"
    var genResult:UInt32 = 0
    result = result + "\nRandom number from SecRandomCopyBytes: "
    do {
        try genResult = generateUInt32()
    } catch (RandNumberTestError.randomGenerator(let str)){
        result = result + str
    } catch {
        
    }
    result = result + "\(genResult)\n"
    result = result + "\nRandom number from arc4random: \(arc4random())"
    return result
}

//generate UInt32 from SecRandomCopyBytes
func generateUInt32() throws -> UInt32 {
    var randomBuffer = [UInt8](repeating: 0, count: 4)
    if (SecRandomCopyBytes(kSecRandomDefault, 4, &randomBuffer) != 0) {
        throw RandNumberTestError.randomGenerator("SecRandomCopyBytes error")
    }
    var randomNumber: UInt32 = 0
    for i in 0..<4 {
        let byte = randomBuffer[i]
        randomNumber |= (UInt32(byte) << UInt32(8 * i))
    }
    return randomNumber
}
