//
//  CypherSwift.swift
//  Created by Sofia Swidarowicz on 01/11/15.
//  Copyright © 2015 Sofia Swidarowicz. All rights reserved.
//

import UIKit
import CryptoSwift


class CypherSwift: NSObject {
    
    
    func tripleDesEncrypt(pass: String) -> String{
        //help from this thread
        //http://stackoverflow.com/questions/25754147/issue-using-cccrypt-commoncrypt-in-swift
        
        let keyString        = "25d1d4cb0a08403e2acbcbe0"
        let keyData: NSData! = (keyString as NSString).dataUsingEncoding(NSUTF8StringEncoding) as NSData!
        
        let message       = pass
        let data: NSData! = (message as NSString).dataUsingEncoding(NSUTF8StringEncoding) as NSData!
        
        let cryptData    = NSMutableData(length: Int(data.length) + kCCBlockSize3DES)!

        let keyLength              = size_t(kCCKeySize3DES)
        let operation: CCOperation = UInt32(kCCEncrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
            algoritm,
            options,
            keyData.bytes, keyLength,
            nil,
            data.bytes, data.length,
            cryptData.mutableBytes, cryptData.length,
            &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            
            // Not all data is a UTF-8 string so Base64 is used
            var base64cryptString = cryptData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            
            print("base64cryptString = \(base64cryptString)")
            base64cryptString = base64cryptString + "\n"
            return encodeString(base64cryptString)
        
        } else {
            print("Error: \(cryptStatus)")
        }
        return ""
    }
    
    func encodeString(str: String) -> String{
        let customAllowedSet =  NSCharacterSet(charactersInString:"==\n").invertedSet
        let escapedString = str.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        print("escapedString: \(escapedString)")
        return escapedString!
    
    }

}
