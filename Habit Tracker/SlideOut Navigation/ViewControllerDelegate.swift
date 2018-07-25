//
//  ViewControllerDelegate.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/20/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

@objc
protocol ViewControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanels()
}
