//
//  ViewController.swift
//  PersonalityTest
//
//  Created by Ewen on 2021/8/6.
//

import UIKit

class ViewController: UIViewController, ResultViewControllerProtocol {
    var currentQuestionIndex = 0
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    
    func createGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 50/255, green: 8/255, blue: 103/255, alpha: 1).cgColor,
            UIColor(red: 46/255, green: 206/255, blue: 207/255, alpha: 1).cgColor,
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.locations = [0, 0.6]
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientBackground()
        choiceOneButton.layer.cornerRadius = 10
        choiceOneButton.clipsToBounds = true
        choiceTwoButton.layer.cornerRadius = 10
        choiceTwoButton.clipsToBounds = true
        
        displayQuestion()
        
        
    }
    
    // 顯示第currentQuestionIndex的選項
    func displayQuestion() {
        choiceOneButton.setTitle(questions[currentQuestionIndex].choices[0].content, for: .normal)
        choiceTwoButton.setTitle(questions[currentQuestionIndex].choices[1].content, for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var personalityTypeText = ""
        var index = 0
        
        currentQuestionIndex += 1
        progressBar.progress = Float(currentQuestionIndex) / Float(questions.count) // 更新進度條
        
        // 沒下一題了，計算是哪一個人格 type，回傳字串
        if currentQuestionIndex == questions.count {
            personalityTypeText = computePersonalityType()
            
            // 求出 personalityTypeText 屬於的 struct 在陣列中的 index
            switch personalityTypeText {
            case "INTJ": index = 0
            case "INTP": index = 1
            case "ENTJ": index = 2
            case "ENTP": index = 3
            case "INFJ": index = 4
            case "INFP": index = 5
            case "ENFJ": index = 6
            case "ENFP": index = 7
            case "ISTJ": index = 8
            case "ISFJ": index = 9
            case "ESTJ": index = 10
            case "ESFJ": index = 11
            case "ISTP": index = 12
            case "ISFP": index = 13
            case "ESTP": index = 14
            case "ESFP": index = 15
            default: break
            }
            
            // 把 personalities[index] 和 index 分別傳給 resultVC 的屬性
            if let resultVC = storyboard?.instantiateViewController(identifier: "ResultVC") as? ResultViewController {
                resultVC.delegate = self //restart功能用
                
                resultVC.personalityInfo = personalities[index]
                resultVC.personalityIndex = index
                
                resultVC.modalPresentationStyle = .overCurrentContext
                present(resultVC, animated: true)
            }
        } else if currentQuestionIndex < questions.count { // 還有題目
            if sender.tag == 0 {
                // 點到上面的按鈕，對應選項的score + 1
                questions[currentQuestionIndex - 1].choices[0].score += 1
            } else {
                // 點到下面的按鈕，對應選項的score + 1
                questions[currentQuestionIndex - 1].choices[1].score += 1
            }
            displayQuestion() // 顯示下題
        }
    }
    
    func computePersonalityType() -> String {
        let I_Score =
        questions[0].choices[1].score +
        questions[4].choices[0].score +
        questions[8].choices[0].score +
        questions[12].choices[0].score +
        questions[16].choices[0].score +
        questions[20].choices[1].score +
        questions[24].choices[1].score +
        questions[28].choices[1].score
        let E_Score =
        questions[0].choices[0].score +
        questions[4].choices[1].score +
        questions[8].choices[1].score +
        questions[12].choices[1].score +
        questions[16].choices[1].score +
        questions[20].choices[0].score +
        questions[24].choices[0].score +
        questions[28].choices[0].score
        
        let N_Score =
        questions[1].choices[0].score +
        questions[5].choices[1].score +
        questions[9].choices[0].score +
        questions[13].choices[0].score +
        questions[17].choices[0].score +
        questions[21].choices[0].score +
        questions[25].choices[1].score +
        questions[29].choices[0].score
        let S_Score =
        questions[1].choices[1].score +
        questions[5].choices[0].score +
        questions[9].choices[1].score +
        questions[13].choices[1].score +
        questions[17].choices[1].score +
        questions[21].choices[1].score +
        questions[25].choices[0].score +
        questions[29].choices[1].score
        
        let T_Score =
        questions[2].choices[0].score +
        questions[6].choices[0].score +
        questions[10].choices[0].score +
        questions[14].choices[1].score +
        questions[18].choices[1].score +
        questions[22].choices[1].score +
        questions[26].choices[0].score +
        questions[30].choices[1].score
        let F_Score =
        questions[2].choices[1].score +
        questions[6].choices[1].score +
        questions[10].choices[1].score +
        questions[14].choices[0].score +
        questions[18].choices[0].score +
        questions[22].choices[0].score +
        questions[26].choices[1].score +
        questions[30].choices[0].score
        
        let P_Score =
        questions[3].choices[0].score +
        questions[7].choices[0].score +
        questions[11].choices[0].score +
        questions[15].choices[0].score +
        questions[19].choices[1].score +
        questions[23].choices[1].score +
        questions[27].choices[0].score +
        questions[31].choices[1].score
        let J_Score =
        questions[3].choices[1].score +
        questions[7].choices[1].score +
        questions[11].choices[1].score +
        questions[15].choices[1].score +
        questions[19].choices[0].score +
        questions[23].choices[0].score +
        questions[27].choices[1].score +
        questions[31].choices[0].score
        
        var typeString = ""
        
        let arrTemp1 = ["I", "E"]
        if  I_Score > E_Score {
            typeString += "I"
        } else if I_Score < E_Score {
            typeString += "E"
        } else {
            typeString += arrTemp1.randomElement()!
        }
        
        let arrTemp2 = ["N", "S"]
        if  N_Score > S_Score {
            typeString += "N"
        } else if  N_Score < S_Score {
            typeString += "S"
        } else {
            typeString += arrTemp2.randomElement()!
        }
        
        let arrTemp3 = ["T", "F"]
        if  T_Score > F_Score {
            typeString += "T"
        } else if T_Score < F_Score {
            typeString += "F"
        } else {
            typeString += arrTemp3.randomElement()!
        }
        
        let arrTemp4 = ["P", "J"]
        if P_Score > J_Score {
            typeString += "P"
        } else if P_Score < J_Score {
            typeString += "J"
        } else {
            typeString += arrTemp4.randomElement()!
        }
        
        return typeString
    }
    
    // ResultViewControllerProtocol Methods
    func dialogDismissed() {
        // score歸零
        for i in 0..<questions.count {
            questions[i].choices[0].score = 0
            questions[i].choices[1].score = 0
        }
        currentQuestionIndex = 0 // 指標回到第1題
        progressBar.progress = 0 // 進度條歸零
        displayQuestion() // 顯示問題
    }
}
