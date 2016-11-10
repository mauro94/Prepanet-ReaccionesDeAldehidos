//
//  setUpExamDb.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Fabian Montemayor on 11/5/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import Foundation
import RealmSwift

struct QuestionStruct {
    var question : String!
    var right : String!
    var wrong : String!
    var image : String?
}

struct ExamStruct {
    var questions : [QuestionStruct]!
}

func serializeStrings(values: [String], separator: String) -> String {
    var result = ""
    for str in values {
        result = result + str + separator
    }
    // remove last character (is an extra separator)
    result.remove(at: result.index(before: result.endIndex))
    return result
}

func deserializeString(value: String, separator: Character) -> [String] {
    var val = value
    var result = [String]()
    var pos = val.characters.index(of: separator)
    
    while pos != nil {
        result.append(val.substring(to: pos!))
        val = val.substring(from: val.index(pos!, offsetBy: 1))
        pos = val.characters.index(of: separator)
    }
    
    result.append(val)
    
    return result
}

class SetUpExams {
    init() {
        //database
        let easy = setUpEasyExam()
        let medium = setUpMediumExam()
        let hard = setUpHardExam()
        
        let realm = try! Realm()
        
        //create database
        try! realm.write {
            realm.add(easy)
            realm.add(medium)
            realm.add(hard)
        }
    }
    
    func setUpEasyExam() -> Exam {
        var easyQuestions = [QuestionStruct]()
        
        let questionOne = QuestionStruct(question: "¿Cuántos carbonos tiene el metanal?", right: "1", wrong: "2%3%4", image: nil)
        let questionTwo = QuestionStruct(question: "¿Cuántos carbonos tiene el hexanal?", right: "6", wrong: "3%7%8", image: nil)
        let questionThree = QuestionStruct(question: "¿Cuál compuesto se forma en esta reacción?", right: "Metanal", wrong: "Hexanal%Pentanal%Etanal", image: "qMetanal")
        let questionFour = QuestionStruct(question: "¿En dónde se encuentra el carbonilo en un aldehído?", right: "En un extremo", wrong: "En medio%En una rama%Todas son correctas", image: nil)
        let questionFive = QuestionStruct(question: "Un aldehído se forma a partir de...", right: "Un carbono unido a la cadena principal, a un hidrógeno y a un oxígeno por doble enlace.", wrong: "Un carbono unido a un oxígeno por un doble enlace y dos carbones.%Un carbono unido a un oxígeno por un doble enlace, a otro oxígeno, a la cadena principal y a un hidrógeno.%Un carbono más un oxígeno con un enlace simple.", image: nil)
        let questionSix = QuestionStruct(question: "¿Cuántos carbonos tiene un propanal?", right: "3", wrong: "1%2%4", image: nil)
        let questionSeven = QuestionStruct(question: "¿Cuántos carbonos tiene un ciclopentano-carbaldehído?", right: "6", wrong: "5%3%4", image: nil)
        
        easyQuestions.append(questionOne)
        easyQuestions.append(questionTwo)
        easyQuestions.append(questionThree)
        easyQuestions.append(questionFour)
        easyQuestions.append(questionFive)
        easyQuestions.append(questionSix)
        easyQuestions.append(questionSeven)
        
        let exam = Exam()
        for q in easyQuestions {
            let question = Question()
            question.question = q.question
            question.right = q.right
            question.wrong = q.wrong
            question.image = q.image
            exam.questions.append(question)
        }
        exam.name = "Easy"
        return exam
    }
    
    func setUpMediumExam() -> Exam {
        var mediumQuestions = [QuestionStruct]()
        
        let questionOne = QuestionStruct(question: "¿Cuál compuesto se forma en esta reacción?", right: "Furan-2-metanal", wrong: "Ciclopentanal%Hexanal%Nonanal", image: "qFuran2metanal")
        let questionTwo = QuestionStruct(question: "¿Cuál compuesto se forma en esta reacción?", right: "Benzaldehído", wrong: "Furan-2-metanal%Octanal%Nonanal", image: "qBenzaldehido")
        let questionThree = QuestionStruct(question: "¿Cuántos carbonos tiene el Ciclohexanocarbaldehído?", right: "7", wrong: "6%9%5", image: nil)
        let questionFour = QuestionStruct(question: "¿Cuál es el nombre trivial del metanal?", right: "Formaldehído", wrong: "Benzaldehído%Acetaldehído%Acroleína", image: nil)
        let questionFive = QuestionStruct(question: "¿Cuál compuesto se utiliza para la fabricación de plásticos y resinas y en las industrias fotográficas, de exposivos y de colorantes?", right: "Metanal", wrong: "Etanal%Butanal%Benzaldehído", image: nil)
        let questionSix = QuestionStruct(question: "¿Cuál es el nombre trivial del Prop-2-enal?", right: "Acroleína", wrong: "Furfural%Baldehína%Acetaldehído", image: nil)
        let questionSeven = QuestionStruct(question: "Nombre del producto:", right: "Acetaldehído", wrong: "Hexanal%Metanal%Butanal", image: "qAcetaldehido")
        
        mediumQuestions.append(questionOne)
        mediumQuestions.append(questionTwo)
        mediumQuestions.append(questionThree)
        mediumQuestions.append(questionFour)
        mediumQuestions.append(questionFive)
        mediumQuestions.append(questionSix)
        mediumQuestions.append(questionSeven)
        
        let exam = Exam()
        for q in mediumQuestions {
            let question = Question()
            question.question = q.question
            question.right = q.right
            question.wrong = q.wrong
            question.image = q.image
            exam.questions.append(question)
        }
        exam.name = "Medium"
        return exam
    }

    func setUpHardExam() -> Exam {
        var hardQuestions = [QuestionStruct]()
        
        let questionOne = QuestionStruct(question: "¿Cuál compuesto se utiliza para la fabricación de plásticos, herbicidas y pesticidas?", right: "Furan-2-metanal", wrong: "Benzaldehído%Prop-2-enal%Nonanal", image: nil)
        let questionTwo = QuestionStruct(question: "¿Cuál compuesto se utiliza para la fabricación de plásticos y productos acrílicos en la industria textil y farmacéutica?", right: "Prop-2-enal", wrong: "Decanal%Butanal%Ciclohexanal", image: nil)
        let questionThree = QuestionStruct(question: "¿Cuál compuesto se produce a partir de glicerina? (Deshidratación)", right: "Prop-2-enal", wrong: "Nonanal%Acetaldehído%Ciclohexanal", image: nil)
        let questionFour = QuestionStruct(question: "¿Cuál compuesto se produce a partir de la hidratación del acetileno?", right: "Acetaldehído", wrong: "Prop-2-enal%Nonanal%Ciclohexanal", image: nil)
        let questionFive = QuestionStruct(question: "¿Cuál compuesto se utiliza para la industria química en muchos procesos (producto inflamable)?", right: "Etanal", wrong: "Hexanal%Pentanal%Ciclopentanal", image: nil)
        let questionSix = QuestionStruct(question: "¿Cuál compuesto se forma en esta reacción?", right: "Ciclohexanocarbaldehído", wrong: "Furan-2-metanal%Benzaldehído%Nonanal", image: "qCiclohexanocarbaldehido")
        let questionSeven = QuestionStruct(question: "¿Cuál compuesto se forma en esta reacción?", right: "Prop-2-enal", wrong: "Propanal%Butanal%Pentanal", image: "qProp2enal")
        
        hardQuestions.append(questionOne)
        hardQuestions.append(questionTwo)
        hardQuestions.append(questionThree)
        hardQuestions.append(questionFour)
        hardQuestions.append(questionFive)
        hardQuestions.append(questionSix)
        hardQuestions.append(questionSeven)
        
        let exam = Exam()
        for q in hardQuestions {
            let question = Question()
            question.question = q.question
            question.right = q.right
            question.wrong = q.wrong
            question.image = q.image
            exam.questions.append(question)
        }
        exam.name = "Hard"
        return exam
    }
}
