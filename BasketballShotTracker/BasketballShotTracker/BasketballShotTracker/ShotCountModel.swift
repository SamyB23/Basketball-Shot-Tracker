import Foundation

class ShotCountModel{
    
    private var made = Double(0)
    private var taken = Double(0)
    private var success = Bool(false)
    private var text = String("")
    var finish = Bool(false)
    
    //  init(made:Double, taken:Double, success:Bool, text:String, finish:Bool){
    //        self.made = 0
    //        self.taken = 0
    //        self.success = false
    //        self.text = ""
    //        self.finish = false
    // }
    
    func addShot(success:Bool){
        if finish != true{
            taken += 1
            if success == true{
                made += 1
            }
        }
    }
    
    func shotsTaken() -> Int{
        return Int(taken)
    }
    
    func shotsMade() -> Int{
        return Int(made)
    }
    
    func generateText() -> String{
        if finish == true && taken != 0{
            text = ""
            text += "Great shooting! Your average is: " + String(round((calculateAverage()*100))/100) + "%"
            resetShots()
        }
        else if made == 0 && taken == 0 && finish == false{
            text = ""
            text += "Start shooting! Your average will be displayed here once you hit the finish button."
        }
        else if finish == true && taken == 0{
            text = ""
            text += "Hey genius, actually take a shot before you press finish."
        }
        return text
    }
    
    func finishShooting(){
        finish = true
    }
    
    func resetShots() {
        made = 0
        taken = 0
        finish = false
    }
    
    func calculateAverage() -> Double {
        return (made/taken)*100
    }
    
    func generateRatio() -> String {
        return "Number of shots made: " + String(shotsMade()) + "/" + String(shotsTaken())
    }
}
