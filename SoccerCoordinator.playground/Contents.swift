// list of player data in separate dictionaries
let name = "name"
let height = "height"
let experience = "experience"
let guardians = "guardians"

let players: [[String: String]] = [
    [
        name: "Joe Smith",
        height: "42.0",
        experience: "true",
        guardians: "Jim and Jan Smith"
    ],

    [
        name: "Jill Tanner",
        height: "36.0",
        experience: "true",
        guardians: "Clara Tanner"
    ],

    [
        name: "Bill Bon",
        height: "43.0",
        experience: "true",
        guardians: "Sara and Jenny Bon"
    ],

    [
        name: "Eva Gordon",
        height: "45.0",
        experience: "false",
        guardians: "Wendy and Mike Gordon"
    ],

    [
        name: "Matt Gill",
        height: "40.0",
        experience: "false",
        guardians: "Charles and Sylvia Gill"
    ],

    [
        name: "Kimmy Stein",
        height: "41.0",
        experience: "false",
        guardians: "Bill and Hillary Stein"
    ],

    [
        name: "Sammy Adams",
        height: "45.0",
        experience: "false",
        guardians: "Jeff Adams"
    ],

    [
        name:  "Karl Saygan",
        height: "42.0",
        experience: "true",
        guardians: "Heather Bledsoe"
    ],

    [
        name: "Suzane Greenberg",
        height: "44.0",
        experience: "true",
        guardians: "Henrietta Dumas"
    ],

    [
        name: "Sal Dali",
        height: "41.0",
        experience: "false",
        guardians: "Gala Dali"
    ],

    [
        name: "Joe Kavalier",
        height: "39.0",
        experience: "false",
        guardians: "Sam and Elaine Kavalier"
    ],

    [
        name: "Ben Finkelstein",
        height: "44.0",
        experience: "false",
        guardians: "Aaron and Jill Finkelstein"
    ],

    [
        name: "Diego Soto",
        height: "41.0",
        experience: "true",
        guardians: "Robin and Sarika Soto"
    ],

    [
        name: "Chloe Alaska",
        height: "47.0",
        experience: "false",
        guardians: "David and Jamie Alaska"
    ],

    [
        name: "Arnold Willis",
        height: "43.0",
        experience: "false",
        guardians: "Claire Willis"
    ],

    [
        name: "Phillip Helm",
        height: "44.0",
        experience: "true",
        guardians: "Thomas Helm and Eva Jones"
    ],

    [
        name: "Les Clay",
        height: "42.0",
        experience: "true",
        guardians: "Wynonna Brown"
    ],

    [
        name: "Herschel Krustofski",
        height: "45.0",
        experience: "true",
        guardians: "Hyman and Rachel Krustofski"
    ]
]


// initialize empty arrays to hold players when sorted by experience

var someExperience: [[String: String]] = []
var noExperience: [[String: String]] = []


// loop to iterate through players and sort by experience

for player in players {
        if let playerExperience = player[experience], let boolExp = Bool(playerExperience) {
        if boolExp {
            someExperience.append(player)
        } else {
            noExperience.append(player)
        }
    }
}


// sort each player group by height, ascending, in preparation for height distribution

let sortedExperienced = someExperience.sorted {(left: [String: String], right: [String: String]) -> Bool in
    guard let leftHeight = left[height], let doubledLeft = Double(leftHeight), let rightHeight = right[height], let doubledRight = Double(rightHeight) else {
        return false }
        return doubledLeft < doubledRight
    }

let sortedInexperienced = someExperience.sorted {(left: [String: String], right: [String: String]) -> Bool in
    guard let leftHeight = left[height], let doubledLeft = Double(leftHeight), let rightHeight = right[height], let doubledRight = Double(rightHeight) else {
        return false }
    return doubledLeft < doubledRight
}


// initialize empty arrays for teams

var teamSharks: [[String: Any]] = []
var teamDragons: [[String: Any]] = []
var teamRaptors: [[String: Any]] = []


// function to distribute experienced and inexperienced groups to teams based on height

func dividePlayers(playerGroup: [[String: Any]]) {

    let total = playerGroup.count // get total of players
    let thirds = total / 3 // determine how many players will fit into each team (size of a third)
    
    /* establish ranges for height distribution
       divide groups of players (which were sorted previously from low to high height)
       into three height ranges - low, medium, and high, using calculated size of a third to break them up evenly */
    let firstThird = thirds
    let secondThird = thirds * 2
    let thirdThird = thirds * 3
    
    let firstRange = playerGroup[0..<(firstThird)] // low range
    let secondRange = playerGroup[firstThird..<(secondThird)] // medium range
    let thirdRange = playerGroup[secondThird..<(thirdThird)] // high range
    
    /* EXPLANATION of the below
        this code iterates through each height range, assigning lowest and highest heights to the same team
        i is used to represent index, and assign each number in turn, computed count-1 prevents loop from going out of bounds
     
        process looks like this  [1,2,2] [3,4,5] [6,6,7]
                                  ^       ^           ^    first group receives lowest and highest values
                                    ^       ^       ^      second group receives next value (+1 index for 1st and 2nd group, -1 for 3rd)
                                      ^       ^   ^        then third group
     
        resulting in these group assignments: (1,3,7) - average 3.6 (2,4,6) - average 4 (2,5,6) - average 4.3
        these numbers have an average within a 1.5 range of each other
        an unconventional approach, but based on what worked on paper, and it works with different number sets
    */
    
    // distribute low height range across teams, using logic explained above
    for _ in 1..<firstRange.count-1 {
        var i = 0
        teamSharks.append(firstRange[i])
        i += 1
        teamDragons.append(firstRange[i])
        i += 1
        teamRaptors.append(firstRange[i])
        i += 1
    }
    
    // distribute medium height range across teams, using logic explained above
    for _ in 1..<secondRange.count-1 {
        var i = thirds
        teamSharks.append(secondRange[i])
        i += 1
        teamDragons.append(secondRange[i])
        i += 1
        teamRaptors.append(secondRange[i])
        i += 1
    }

    // distribute high height range across teams, using logic explained above
    for _ in 1..<thirdRange.count-1 {
        var i = thirdRange.count*thirds - 1 // this is used to start counting from the last index value
        teamSharks.append(thirdRange[i])
        i -= 1
        teamDragons.append(thirdRange[i])
        i -= 1
        teamRaptors.append(thirdRange[i])
        i -= 1
    }
}


// call function to divide each group of players into teams

dividePlayers(playerGroup: sortedInexperienced)
dividePlayers(playerGroup: sortedExperienced)


// function to compute average height per team
func averageHeight(for team: [[String: Any]]) -> Double {
    var totalHeight: Double = 0
    
    for player in team {
        if let playerHeight = player[height] as? Double {
        totalHeight += playerHeight // add all player heights together
        }
    }
    
    let teamCount = Double(team.count) // get total number of players
    
    let averageHeight = totalHeight / teamCount // divide total height by number of players
    return averageHeight
}

// call functions for average team height and assign to variables
let teamRaptorsAverageHeight = averageHeight(for: teamRaptors)
let teamDragonsAverageHeight = averageHeight(for: teamDragons)
let teamSharksAverageHeight = averageHeight(for: teamSharks)

print("Raptors average height: \(teamRaptorsAverageHeight) \nDragons average height: \(teamDragonsAverageHeight) \nSharks average height: \(teamSharksAverageHeight) \n")


// iterate through players and create letters

var letters: [String] = [] // empty array to hold letters


// reusable function to generate letters with team and date inputs
func createLetters(team: [[String: Any]], teamName: String, practiceDate: String) {
    
    for player in team {
        if let playerGuardian = player[guardians], let playerName = player[name] {
        let letter = "Dear \(playerGuardian), \nYour child, \(playerName), has been placed on the \(teamName) team for the soccor league. The \(teamName) have their first practice set for \(practiceDate), so please be certain that your child attends, has the proper equipment, and brings along lots of energy. It is very important that \(name) attend the practice, so be sure to mark the date and time on your calendars! \nWe look forward to seeing you there!\n"
        letters.append(letter)
        }
    }   
}

// call function to create letters

createLetters(team: teamRaptors, teamName: "Raptors", practiceDate: "March 18, 1pm")
createLetters(team: teamDragons, teamName: "Dragons", practiceDate: "March 17, 1pm")
createLetters(team: teamSharks, teamName: "Sharks", practiceDate: "March 17, 3pm")


// output to console
for letter in letters {
    print(letter)
}



