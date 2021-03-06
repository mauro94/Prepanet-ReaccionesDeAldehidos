//
//  ExamViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 10/31/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit
import RealmSwift

class ExamViewController: UIViewController {
    
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer1: UIButton!
	
	@IBOutlet weak var barItemEnd: UIBarButtonItem!
	@IBOutlet weak var barItemNext: UIBarButtonItem!
	
	@IBOutlet weak var lblFeedback: UILabel!
	
    lazy var buttons: [UIButton] = { return [self.btnAnswer1, self.btnAnswer2, self.btnAnswer3, self.btnAnswer4] }()
    
    @IBOutlet weak var lblQuestionWImg: UILabel!
    @IBOutlet weak var lblQuestionNoImg: UILabel!
    @IBOutlet weak var imgQuestion: UIImageView!
	
    var difficulty = ""
    var points = 0
    var questions = [Question]()
    var currentQuestionIndex = 0
    var currentAnswers = [String]()
    var answered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        points = 0
        currentQuestionIndex = 0
        
        let realm = try! Realm()
        var exam = Exam()
        if difficulty != "" {
            let predicate = NSPredicate(format: "name == %@", difficulty)
            exam = realm.objects(Exam.self).filter(predicate).first!
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
        
        questions = exam.questions.shuffled()
        
        updateLabelsAndButtonsForIndex(questionIndex: 0)
		
		barItemNext.target = self
		barItemNext.action = #selector(didTapNextButton(_:))
		
		barItemEnd.target = self
		barItemEnd.action = #selector(didTapEndButton(_:))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabelsAndButtonsForIndex(questionIndex : Int) {
        if questionIndex < questions.count {
			self.title = "Pregunta " + "\(questionIndex+1)"
            currentQuestionIndex = questionIndex
            let currentQuestion = questions[questionIndex]
            if currentQuestion.image != nil {
                // Question has an image
                
                // Update question
                lblQuestionNoImg.isHidden = true
                lblQuestionWImg.isHidden = false
                imgQuestion.isHidden = false
                imgQuestion.image = UIImage(named: currentQuestion.image!)
                lblQuestionWImg.text = currentQuestion.question  
            }
            else {
                // Question has no image
                // Update question
                lblQuestionNoImg.isHidden = false
                lblQuestionWImg.isHidden = true
                imgQuestion.isHidden = true
                lblQuestionNoImg.text = currentQuestion.question
            }
            
            // Update buttons
            var answers = deserializeString(value: currentQuestion.wrong, separator: "%")
            answers.append(currentQuestion.right)
            currentAnswers = answers.shuffled()
            
            for (answerIndex, button) in buttons.enumerated() {
                button.setTitle(currentAnswers[answerIndex], for: .normal)
                button.isHidden = false
            }
            
            hideUnhideNext()
        }
        else {
            lblQuestionWImg.isHidden = true
            imgQuestion.isHidden = true
            lblQuestionNoImg.isHidden = true
			barItemNext.isEnabled = false
            lblFeedback.isHidden = false
            lblFeedback.text = "¡Terminaste! Tu puntuación es: " + "\(points)" + "/" + "\(questions.count)"
            
            for button in buttons {
                button.isHidden = true
            }
        }
    }
    
    func hideUnhideNext() {
        if !barItemNext.isEnabled {
			barItemNext.isEnabled = true
        }
        else {
			barItemNext.isEnabled = false
        }
    }
    
    @IBAction func didTapAnswerButton(sender: UIButton) {
        if !answered {
            hideUnhideNext()
            let buttonIndex = buttons.index(of: sender)
            
            if currentAnswers[buttonIndex!] == questions[currentQuestionIndex].right {
                points += 1
				sender.backgroundColor = UIColor(red: 104/255, green: 191/255, blue: 86/255, alpha: 1)
            }
            else {
				sender.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
            }
            answered = true
			
			for bt in buttons {
				bt.isEnabled = false
			}
        }
    }
    
    
	func didTapNextButton(_ sender: UIBarButtonItem) {
        updateLabelsAndButtonsForIndex(questionIndex: currentQuestionIndex + 1)
        answered = false
		
		for bt in buttons {
			bt.backgroundColor = UIColor(red: 42/255, green: 70/255, blue: 101/255, alpha: 1)
			bt.isEnabled = true
		}
    }
    
    func didTapEndButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        answered = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
