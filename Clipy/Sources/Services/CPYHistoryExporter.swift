//
//  CPYHistoryExporter.swift
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
import RealmSwift

class CPYHistoryExporter {
    
    // MARK: - Public Methods
    func exportHistory() {
        guard let historyItems = allHistoryItems() else {
            NSSound.beep()
            return
        }
        
        let content = historyItems.joined(separator: "\n")
        
        let panel = NSSavePanel()
        panel.accessoryView = nil
        panel.canSelectHiddenExtension = true
        panel.allowedFileTypes = ["txt"]
        panel.allowsOtherFileTypes = false
        panel.directoryURL = URL(fileURLWithPath: NSHomeDirectory())
        panel.nameFieldStringValue = "clipboard_history"
        let returnCode = panel.runModal()
        
        if returnCode != NSApplication.ModalResponse.OK { return }
        
        guard let url = panel.url else { return }
        
        do {
            try content.write(to: url, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            NSSound.beep()
        }
    }
    
    // MARK: - Private Methods
    private func allHistoryItems() -> [String]? {
        do {
            let realm = try Realm()
            let clips = realm.objects(CPYClip.self)
                .sorted(byKeyPath: #keyPath(CPYClip.updateTime), ascending: false)
            
            return clips.compactMap { clip in
                // Return the title (text content) of each clip, skipping empty ones
                clip.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : clip.title
            }
        } catch {
            return nil
        }
    }
}