//
//  StringEncryption.swift
//  BusinessTime
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 Five0314. All rights reserved.
//

import UIKit

extension NSString{
    /**
     去除首位空格
     */
    func trim() -> NSString {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    /**
     MD5(16位)加密，OC版
     
     - returns: MD5加密结果（CC_MD5_DIGEST_LENGTH:长度32）
     */
    func CNMD5() -> NSString{
        return self.CNMD5(Int(CC_MD5_DIGEST_LENGTH))
    }
    
    /**
     MD5加密，OC版
     
     - parameter digestLen: Int(CC_MD5_DIGEST_LENGTH) 16、Int(CC_MD5_BLOCK_BYTES) 64
     
     - returns: MD5加密结果（CC_MD5_DIGEST_LENGTH:长度32、CC_MD5_BLOCK_BYTES:长度128）
     */
    func CNMD5(digestLen:Int) -> NSString{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)//UTF8
        
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str, strLen, result)
        
        let hash = NSMutableString()
        
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return NSString(format: hash)
    }
}

extension String{
    
    /**
     去除首位空格
     */
    func trim() -> String {
//        NSError *error = NULL;
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularString options:NSRegularExpressionDotMatchesLineSeparators error:&error];//正则匹配
//        NSArray * arr = [regex matchesInString:message options:0 range:NSMakeRange(0, [message length])];//匹配结果

        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    /**
     MD5(16位)加密
     
     - returns: MD5加密结果（CC_MD5_DIGEST_LENGTH:长度32）
     */
    func CNMD5() -> String{
        return self.CNMD5(Int(CC_MD5_DIGEST_LENGTH))
    }
    
    /**
     MD5加密
     
     - parameter digestLen: Int(CC_MD5_DIGEST_LENGTH) 16、Int(CC_MD5_BLOCK_BYTES) 64
     
     - returns: MD5加密结果（CC_MD5_DIGEST_LENGTH:长度32、CC_MD5_BLOCK_BYTES:长度128）
     */
    func CNMD5(digestLen:Int) -> String{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)//UTF8
        
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
}


