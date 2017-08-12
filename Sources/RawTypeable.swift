//
//  RawTypeable.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit


public protocol RawTypeable{
    init?(_:String)
    init?(_:Int)
}

extension String:RawTypeable{}

extension Int:RawTypeable{
    public init?(_ value:String){
        self.init(value)
    }
}
