//
//  Typealias.swift
//  Vines
//
//  Created by Patrick Marshall on 08/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import Foundation

public typealias DateClosure = (Date) -> Void
public typealias OptionalDateClosure = (Date?) -> Void
public typealias VoidClosure = () -> Void
public typealias BoolClosure = (Bool) -> Void
public typealias StringClosure = (String) -> Void
public typealias StringTransformerClosure = (String) -> String
public typealias IntClosure = (Int) -> Void
public typealias IntBoolClosure = (Int, Bool) -> Void
public typealias ProductClosure = (ProductListModelData) -> Void
public typealias Int64Closure = (Int64) -> Void
public typealias EventHandler = (Notification?) -> Void
public typealias OptionalTexter = () -> String?
public typealias Texter = () -> String
public typealias Switcher = Booler
public typealias Booler = () -> Bool
public typealias AttributedTexter = () -> NSAttributedString
public typealias ApiClosure = (URLSessionTask, [String: AnyObject], NSError?) -> Void
public typealias VoidInt64Closure = () -> Int64
