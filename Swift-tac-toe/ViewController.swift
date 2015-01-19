//
//  ViewController.swift
//  Swift-tac-toe
//
//  Created by Veena Nayak on 1/15/15.
//  Copyright (c) 2015 kayann. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    @IBOutlet var ticTacButton1: UIButton!
    @IBOutlet var ticTacButton2: UIButton!
    @IBOutlet var ticTacButton3: UIButton!
    @IBOutlet var ticTacButton4: UIButton!
    @IBOutlet var ticTacButton5: UIButton!
    @IBOutlet var ticTacButton6: UIButton!
    @IBOutlet var ticTacButton7: UIButton!
    @IBOutlet var ticTacButton8: UIButton!
    @IBOutlet var ticTacButton9: UIButton!
 
    @IBOutlet var resetButton: UIButton!

    @IBOutlet var userMessage: UILabel!
    
    //setup plays dictionary - key points to button clicked 0-9 and value is either 0(computer) or 1(player)
    var plays = Dictionary<Int, Int> ()
    
    var aiDeciding = false
    
    var done = false
    
    @IBAction func UIButtonClicked (sender:UIButton) {
        
        userMessage.hidden = true
        
        if (plays[sender.tag] == nil && !aiDeciding && !done) {
        setImageForSpot(sender.tag, player:1)
        }
        
        checkForWin()
        
        aiTurn()
    }
    
    @IBAction func ResetButtonClicked (sender:UIButton) {
        done = false
        resetButton.hidden = true
        userMessage.hidden = true
        reset()
    }
    
    func reset() {
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
    }
    
    func setImageForSpot(spot:Int, player:Int) {
        var playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot {
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg1.image = UIImage(named: playerMark)
        }
    
    }
    
    func checkFor (value:Int, inList: [Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }else {
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func checkBottom (#value:Int) -> (String, String) {
        return ("bottom", checkFor(value, inList: [7,8,9]))
    }
    
    func checkTop (#value:Int) -> (String, String) {
        return ("top", checkFor(value, inList: [1,2,3]))
    }
    
    func checkLeft (#value:Int) -> (String, String) {
        return ("left", checkFor(value, inList: [1,4,7]))
    }
    
    func checkRight (#value:Int) -> (String, String) {
        return ("right", checkFor(value, inList: [3,6,9]))
    }
    
    func checkMiddleAcross (#value:Int) -> (String, String) {
        return ("middleacross", checkFor(value, inList: [4,5,6]))
    }
    
    func checkDiagLeft (#value:Int) -> (String, String) {
        return ("diagleft", checkFor(value, inList: [1,5,9]))
    }
    
    func checkDiagRight (#value:Int) -> (String, String) {
        return ("diagright", checkFor(value, inList: [3,5,7]))
    }
    
    func checkMiddleDown (#value:Int) -> (String, String) {
        return ("middledown", checkFor(value, inList: [2,5,8]))
    }
    
    func rowCheck(#value:Int) ->(String, String) {
        var acceptableFinds = ["011", "110", "101"]
        var findFuncs = [checkTop, checkBottom, checkLeft, checkRight, checkMiddleAcross, checkMiddleDown, checkDiagLeft, checkDiagRight]
        //var algorthmResults = [location:String, pattern:String?]
        for algorthm in findFuncs {
            let algorthmResults = algorthm(value:value)
            if (find(acceptableFinds, algorthmResults.1) != nil) {
                return algorthmResults
                //return (algorthmResults.location, algorthmResults.pattern)
               // return (algorthmResults.location, algorthmResults.pattern)
            }
        }
        let algorthmResults = ("", "")
        return algorthmResults
    }
    func checkForWin() {
        var whoWon = ["I":0, "You":1]
        // println("plays[] = \(plays[1]),\(plays[2]), \(plays[3]), \(plays[4]), \(plays[5]), \(plays[6]), \(plays[7]), \(plays[8]), \(plays[9])")
        
        for (key, value) in whoWon {
            if ((plays[7] == value) && (plays[8] == value) && (plays[9] == value)) {
                displayMsgAndResetButton("\(key)")
            }
            if((plays[4] == value) && (plays[5] == value) && (plays[6] == value)) {
                displayMsgAndResetButton("\(key)")
            }
            if ((plays[1] == value) && (plays[2] == value) && (plays[3] == value)) {
                displayMsgAndResetButton("\(key)")
            }
            if (plays[1] == value && plays[4] == value && plays[7] == value) {
                displayMsgAndResetButton("\(key)")
            }
            if (plays[2] == value && plays[5] == value && plays[8] == value) {
                displayMsgAndResetButton("\(key)")
            }
            if (plays[3] == value && plays[6] == value && plays[9] == value) {
                displayMsgAndResetButton("\(key)")
            }
            if (plays[1] == value && plays[5] == value && plays[9] == value) {
                displayMsgAndResetButton("\(key)")
            }
            if (plays[3] == value && plays[5] == value && plays[7] == value) {
                displayMsgAndResetButton("\(key)")
            }
        }
        
        
    }
    
    func displayMsgAndResetButton(winner:String) {
        // println("Entered displayMsgAndResetButton")
                    userMessage.hidden = false
                    userMessage.text = "Looks like " + winner + " won"
                    resetButton.hidden = false
                    done = true
        //TBD - disable buttons at end of GAME
    }

    func isOccupied(spot:Int) -> Bool {
        return (plays[spot] != nil)
    }
    
    func whereToPlay(location:String, pattern:String) -> Int {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "101"
        
        switch location {
            case "top":
                if pattern == leftPattern {
                    return 1
                }else if pattern == rightPattern {
                    return 3
                }else {
                    return 2
            }
            case "bottom":
               if pattern == leftPattern {
                    return 7
                }else if pattern == rightPattern {
                    return 9
                }else {
                    return 8
            }
            case "left":
                if pattern == leftPattern {
                    return 1
                }else if pattern == rightPattern {
                    return 7
                }else {
                    return 4
            }
            case "right":
                if pattern == leftPattern {
                    return 3
                }else if pattern == rightPattern {
                    return 9
                }else {
                    return 6
            }
            
            case "middledown":
                if pattern == leftPattern {
                    return 2
                }else if pattern == rightPattern {
                    return 8
                }else {
                    return 5
            }
            case "middleacross":
                if pattern == leftPattern {
                    return 4
                }else if pattern == rightPattern {
                    return 6
                }else {
                    return 5
            }
            case "diagleft":
                if pattern == leftPattern {
                    return 1
                }else if pattern == rightPattern {
                    return 9
                }else {
                    return 5
            }
            case "diagright":
                if pattern == leftPattern {
                    return 3
                }else if pattern == rightPattern {
                    return 7
                }else {
                    return 5
            }
        default :
            return 4
            
        }
        
    }//func whereToPlay
    
    func aiTurn() {
        if (done) {
            return
        }
        aiDeciding = true
        
        //Do we have 2 in a row?
        
        var result = rowCheck(value:0)
        if (result.0 != "" && result.1 != "") {
            var whereToPlayResult = whereToPlay(result.0, pattern: result.1)
            if !isOccupied(whereToPlayResult) {
                setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        
        //Does Player have 2 in a row
        result = rowCheck(value: 1)
        if (result.0 != "" && result.1 != "") {
            var whereToPlayResult = whereToPlay(result.0, pattern:result.1)
            if !isOccupied(whereToPlayResult) {
                setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding  = false
                checkForWin()
                return
            }
        }
        
        //is Center available ?
        if !isOccupied(5) {
            setImageForSpot(5, player: 0)
            aiDeciding  = false
            checkForWin()
            return
        }
        
        //is Corner available ?
        if let cornerAvailable = firstAvailable(isCorner: true) {
            setImageForSpot(cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        //is Side available ?
        if let sideAvailable = firstAvailable(isCorner: false)  {
            setImageForSpot(sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        // checkForWin()
        
        //Nothing available must be a TIE!
        userMessage.hidden = false
        userMessage.text = "Looks like it was a TIE!"
        //reset()
        plays = [:]
        resetButton.hidden = false
        aiDeciding = false
        
    }//aiTurn
    
    func firstAvailable(#isCorner:Bool) ->Int? {
        var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
        for spot in spots {
            if !isOccupied(spot) {
                return spot
            }
        }
        return nil
        
    }//firstAvailable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

