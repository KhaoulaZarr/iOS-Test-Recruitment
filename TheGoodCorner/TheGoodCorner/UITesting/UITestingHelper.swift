//
//  UITestingHelper.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 19/09/2026.
//

#if DEBUG

import Foundation

struct UITestingHelper {
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    static var isNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-networking-success"] == "1"
    }
}
#endif
