//
//  SpeechRecognizer.swift
//  SpeechText
//
//  Created by Stanislav Leonchik on /262/22.
//

import Foundation
import Speech

final class SpeechRecognizer {
    
    func requestPermissions() {
        requestMicrophonePermission() { success in
            
        }
        requestRecognitionPermission() { success in
            
        }
    }
    
    // MARK: - Private methods
    
    private func requestMicrophonePermission(complition: ((Bool) -> Void)?) {
        AVAudioSession.sharedInstance().requestRecordPermission { success in
            OperationQueue.main.addOperation {
                complition?(success)
            }
        }
    }
    private func requestRecognitionPermission(complition: ((Bool) -> Void)?) {
        SFSpeechRecognizer.requestAuthorization() { authStatus in
            let success = authStatus == .authorized
            OperationQueue.main.addOperation {
                complition?(success)
            }
        }
    }

    
}
