//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[0]
        questionLabel.text = firstQuestion.questionText
        
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
     
        questionNumber = questionNumber + 1
        
        nextQuestion()
    }
    
    
    func updateUI() {
      
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"   //+1 is used so that to make question numbers 0-12 as 1-13
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)    //To convert questionNumber int to CGFloat
    }
    

    func nextQuestion() {
        
        if questionNumber <= 12
        {
        questionLabel.text = allQuestions.list[questionNumber].questionText //Update question label each time
            
            updateUI()
        }
        else {
            
            /*
            print("End of Quiz")  This is not visible to the user.
            questionNumber = 0  Visible only to programmer.
            */
            
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to restart?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            
            //print("You got it!") -> This is only visible to the developer, not to the user, whether the answer is right or wrong
            ProgressHUD.showSuccess("Correct")
            score = score + 1
        }
        else {
            
            //print("Wrong!") -> This is only visible to the developer, not to the user, whether the answer is right or wrong
            ProgressHUD.showError("Wrong")
        }
        
    }
    
    
    func startOver() {
        
       score = 0
       questionNumber = 0
       nextQuestion()
    }

    

    
}
