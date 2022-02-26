//
//  ViewController.swift
//

import UIKit
import Speech

final class ViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    
    @IBOutlet weak var recognizeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    // MARK: - Properties

    private var recognizer: SpeechRecognizable = SpeechRecognizer()
    
    
    private let text: String = Constants.text
    
    private var isRecordingStarted: Bool = false{
        didSet {
            if isRecordingStarted {
                recognizeButton.backgroundColor = .red
                recognizeButton.setTitle("Стоп", for: .normal)
                recognizer.start()
            } else {
                recognizeButton.backgroundColor = .green
                recognizeButton.setTitle("Старт", for: .normal)
                recognizer.stop()
            }
    }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        recognizer.delegate = self
        recognizer.requestPermissions() { [weak self] success in
            self?.recognizeButton.isEnabled = success
        }
    }

    // MARK: - Beautiful view

    private func configureView() {
        inputTextView.layer.cornerRadius = 5
        inputTextView.autocorrectionType = .no
        inputTextView.attributedText = text.attributed

        outputTextView.layer.cornerRadius = 5
        outputTextView.autocorrectionType = .no
        outputTextView.text = ""

        recognizeButton.layer.cornerRadius = 8
        recognizeButton.shadow()
        recognizeButton.isEnabled = false

        resetButton.layer.cornerRadius = 8
    }

    // MARK: - IBActions

    @IBAction func recognizeButtonTap(_ sender: Any) {
        isRecordingStarted.toggle()
    }

    @IBAction func resetButtonTap(_ sender: Any) {
        inputTextView.attributedText = text.attributed
        outputTextView.text = ""
    }

    @IBAction func onScreenTap(_ sender: Any) {
        view.endEditing(true)
    }
}

extension ViewController: SpeechRecognizerDelegate {
    func output(result: SFSpeechRecognitionResult) {
        guard !result.isFinal else {
            outputTextView.text = result.bestTranscription.formattedString
            return
        }
        let words = result.bestTranscription.segments.compactMap({ $0.substring })
        print("Words:", words.joined(separator: ", "))
    }
}
