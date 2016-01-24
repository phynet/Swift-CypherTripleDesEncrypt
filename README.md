# CypherTripleDesEncrypt
Swift Class to triple DES Encrypt using  keyed-hash message authentication code (HMAC) 

#How To Use:
    import CryptoSwift

###For tripleDES:

    let cypherSwift = CypherSwift()
    let encryptedString = cypherSwift.tripleDesEncrypt(pass) //pass the string password you want to cypher
    
###For HMAC:

    let keyVal = "f25a2s1m11" //use the public key to uncrypt
    var result = keyVal + url.lowercaseString  //using a url where is a signature password to encode
    result = result.hmac(CryptoAlgorithm.SHA256, key: keyVal) //Use any of the hash available, here I'm using 256-bit hash (SHA256) 
     
     
