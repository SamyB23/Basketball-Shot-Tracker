import XCTest
@testable import BasketballShotTracker
class ShotCountModelTest: XCTestCase {
    
    func testThatWhenShotMadeThenShotCountIncrement() {
        let shotMade = true
        
        let testObject = ShotCountModel()
        
        testObject.addShot(success:shotMade)
        
        XCTAssertEqual(testObject.shotsMade(), 1)
        XCTAssertEqual(testObject.shotsTaken(), 1)
    }
    
    func testThatWhenShotMissedThenNoChange() {
        let shotMade = false
        
        let testObject = ShotCountModel()
        
        testObject.addShot(success:shotMade)
        
        XCTAssertEqual(testObject.shotsMade(), 0)
        XCTAssertEqual(testObject.shotsTaken(), 1)
    }
    
    func testThatWhenMultipleShotsMissedThenNoChanges() {
        let shotMade = false

        let testObject = ShotCountModel()

        testObject.addShot(success:shotMade)
        testObject.addShot(success:shotMade)

        XCTAssertEqual(testObject.shotsMade(), 0)
        XCTAssertEqual(testObject.shotsTaken(), 2)
    }

    func testThatWhenFinishShootingThenGenerateStartShootingText() {
        let testObject = ShotCountModel()
        
        let actual = testObject.generateText()
        
        XCTAssertEqual(actual, "Start shooting! Your average will be displayed here once you hit the finish button.")
    }
    
    func testThatWhenFinishShootingWithNoShotsThenGenerateText() {
        let testObject = ShotCountModel()
        
        testObject.finishShooting()
        
        let actual = testObject.generateText()
        
        XCTAssertEqual(actual, "Hey genius, actually take a shot before you press finish.")
    }
    
    func testThatWhenResetShootingThenResetShots() {
        let testObject = ShotCountModel()
        
        testObject.addShot(success: false)
        testObject.addShot(success: true)
        testObject.resetShots()
        
        let actual = testObject.shotsMade()
        let actual1 = testObject.shotsTaken()
        let actual2 = testObject.generateText()
        
        XCTAssertEqual(actual, 0)
        XCTAssertEqual(actual1, 0)
        XCTAssertEqual(actual2, "Start shooting! Your average will be displayed here once you hit the finish button.")
    }
    
    func testThatWhenFinishShootingThenCalculateAverage() {
        let testObject = ShotCountModel()
        let testObject1 = ShotCountModel()
        
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        testObject.addShot(success: false)
        testObject.addShot(success: true)
        
        testObject1.addShot(success: true)
        testObject1.addShot(success: false)
        testObject1.addShot(success: false)
        testObject1.addShot(success: false)
        testObject1.addShot(success: true)

        let actual = testObject.calculateAverage()
        let actual1 = testObject1.calculateAverage()
        
        XCTAssertEqual(actual, 80.0)
        XCTAssertEqual(actual1, 40.0)
    }
    
    func testThatWhenFinishShootingThenReturnTrue() {
        let testObject = ShotCountModel()
        
        let actual = testObject.finish
        
        XCTAssertFalse(actual)
        
        testObject.finishShooting()
        
        let actual2 = testObject.finish
        
        XCTAssertTrue(actual2)
    }
    
    func testThatWhenCalculateAverageThenGenerateRespectiveText() {
        let testObject = ShotCountModel()
        let testObject1 = ShotCountModel()
        
        testObject.addShot(success: false)
        testObject.addShot(success: true)
        
        testObject1.addShot(success: false)
        testObject1.addShot(success: true)
        testObject1.addShot(success: true)
        testObject1.addShot(success: true)
        
        testObject.finishShooting()
        testObject1.finishShooting()
        
        let average = testObject.calculateAverage()
        
        let average1 = testObject1.calculateAverage()
        
        let actual = testObject.generateText()
        let actual1 = testObject1.generateText()
        
        XCTAssertEqual(actual, "Great shooting! Your average is: " + String(average) + "%")
        XCTAssertEqual(actual1, "Great shooting! Your average is: " + String(average1) + "%")
    }
    
    func testThatWhenShotsTakenThenShotRecordDisplayed() {
        let testObject = ShotCountModel()
        let testObject1 = ShotCountModel()
        
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        
        testObject1.addShot(success: false)
        testObject1.addShot(success: true)
        testObject1.addShot(success: true)
        testObject1.addShot(success: true)
        
        let actual = testObject.generateRatio()
        let actual1 = testObject1.generateRatio()
        
        XCTAssertEqual(actual, "Number of shots made: 5/5")
        XCTAssertEqual(actual1, "Number of shots made: 3/4")
    }
    
    func testThatWhenFinishedShootingThenShotsReset() {
        let testObject = ShotCountModel()
        
        testObject.addShot(success: false)
        testObject.addShot(success: true)
        testObject.addShot(success: false)
        testObject.addShot(success: true)
        
        testObject.finishShooting()
        
        let actual = testObject.generateText()
        
        let shotsMadeReset = testObject.shotsMade()
        let shotsTakenReset = testObject.shotsTaken()
        
        XCTAssertEqual(actual, "Great shooting! Your average is: 50.0%")
        XCTAssertEqual(shotsMadeReset, 0)
        XCTAssertEqual(shotsTakenReset, 0)
    }
    
    func testThatWhenFinishedShootingCannotAddMoreShots() {
        let testObject = ShotCountModel()
        
        testObject.addShot(success: true)
        testObject.addShot(success: false)
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        testObject.addShot(success: false)
        
        testObject.finishShooting()
        
        testObject.addShot(success: true)
        testObject.addShot(success: true)
        
        let actual = testObject.generateRatio()
        
        XCTAssertEqual(actual, "Number of shots made: 3/5")
    }
}

