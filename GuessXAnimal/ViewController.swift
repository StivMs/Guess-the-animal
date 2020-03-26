//
//  ViewController.swift
//  GuessXAnimal
//
//  Created by Stivan Mersho on 2020-03-22.
//  Copyright © 2020 Stivan Mersho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var questionLabel: UILabel!
    var animals = [String]()
    var score: Int = 0
    var correctAnswer: Int = 0
    var answeredQuestions: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animals += ["bat","bear", "bee", "bird", "bug", "butterfly",
                    "camel", "cat", "cheetah", "cobra", "cow",
                    "crocodile", "dinosaur", "dog", "dolphin",
                    "dove", "duck", "eagle", "elephant", "fish",
                    "flamingo", "fox", "frog", "giraffe", "gorilla",
                    "hen", "horse", "kangaroo", "koala", "leopard",
                    "lion", "monkey", "mouse", "panda", "parrot",
                    "penguin", "shark", "sheep", "spider", "squirrel",
                    "starfish", "tiger", "turtle", "wolf", "zebra"]
        
        title = "Your score: \(String(score))"
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(showInfo))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Instructions", style: .plain, target: self, action: #selector(showInstructions))
    }
    
    func askQuestion() {
        answeredQuestions += 1
        if(answeredQuestions >= 10) {
            showAlert(title: "Woaah!", titleAction: "Close", alertMessage: "You have answered 10 correct answer, Good job!")
            answeredQuestions = 0
        }
        
        // Shuffle the array with animals
        animals.shuffle()
        // Correct answer is one of the first 3 animals / images
        correctAnswer = Int.random(in: 0...2)
        
        // Change button image to the first images in the array after shuffling
        button1.setImage(UIImage(named: animals[0]), for: .normal)
        button2.setImage(UIImage(named: animals[1]), for: .normal)
        button3.setImage(UIImage(named: animals[2]), for: .normal)
        
        // Change the label to the animal that the user need to find, the correct answer
        questionLabel.text = animals[correctAnswer].uppercased()
        
    }
    
    // Function for handling tapping on the buttons.
    // Compare button tag number with correctAnswer number (Int) and add score
    @IBAction func buttonTapped(_ sender: UIButton) {
        let output: String
        
        if sender.tag == correctAnswer {
            output = "Correct!"
            updateScoreWithValue(value: 1)
        } else {
            output = "Wrong guess! The correct animal was \(animals[correctAnswer])"
            updateScoreWithValue(value: -1)
        }
        showAlert(title: output, titleAction: "Continue", alertMessage: "Your score is: \(score)")
    }
    
    func updateScoreWithValue(value: Int) {
        if score < 0 && value > 0 {
            score = 1
        } else {
            score += value
        }
        title = "Your score: \(String(score))"
    }
    
    func showAlert(title: String, titleAction: String, alertMessage: String){
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleAction, style: .default, handler: {(UIAlertAction) in self.askQuestion()} ))
        present(alert, animated: true)
    }
    
    @objc func showInfo() {
        let alert = UIAlertController(title: "About", message: "This project is made by Stivan Mersho for educational purpose. ⭐️", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func showInstructions() {
        let alert = UIAlertController(title: "Instructions", message: "Match the animal with right picture, simple and fun! ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}

