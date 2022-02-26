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

    private let text: String = Constants.text
    private var isRecordingStarted: Bool = false{
        didSet {
            if isRecordingStarted {
                recognizeButton.backgroundColor = .red
                recognizeButton.setTitle("Стоп", for: .normal)
            } else {
            recognizeButton.backgroundColor = .green
            recognizeButton.setTitle("Старт", for: .normal)
            }
    }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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

