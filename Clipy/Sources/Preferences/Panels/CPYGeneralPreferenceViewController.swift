//
//  CPYGeneralPreferenceViewController.swift
//
//  Clipy
//  GitHub: https://github.com/clipy
//  HP: https://clipy-app.com
//
//  Created by GitHub Copilot on 2024/08/06.
//
//  Copyright © 2015-2018 Clipy Project.
//

import Cocoa

class CPYGeneralPreferenceViewController: NSViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var exportHistoryButton: NSButton!
    
    // MARK: - Initialize
    override func loadView() {
        super.loadView()
    }
    
    // MARK: - IBActions
    @IBAction private func exportHistoryButtonTapped(_ sender: NSButton) {
        let exporter = CPYHistoryExporter()
        exporter.exportHistory()
    }
}