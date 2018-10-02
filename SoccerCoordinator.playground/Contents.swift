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
        if boolExp == true {
            someExperience.append(player)
        } else {
            noExperience.append(player)
        }
    }
}


// sort each player group by height, ascending

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


//let sortedExperienced = someExperience.sorted {($0[height] as? Double) < ($1[height] as? Double)}
//let sortedInexperienced = noExperience.sorted {($0[height] as? Double) < ($1[height] as? Double)}


// initialize empty arrays for teams

var teamSharks: [[String: Any]] = []
var teamDragons: [[String: Any]] = []
var teamRaptors: [[String: Any]] = []


// function to distribute experienced and inexperienced groups to teams based on height

func dividePlayers(playerGroup: [[String: Any]]) {

    let total = playerGroup.count
    let thirds = total / 3 // compute how many players fit in each of the three teams
    
    // establish ranges for height distribution, divide low-high sorted group into thirds
    let firstRange = playerGroup[0..<(thirds)] // low range
    let secondRange = playerGroup[thirds..<(thirds*2)] // medium range
    let thirdRange = playerGroup[thirds*2..<(thirds*3)] // high range
    
    // distribute low height range across teams
    for _ in 1..<firstRange.count-1 {
        var i = 0
        teamSharks.append(firstRange[i])
        i += 1
        teamDragons.append(firstRange[i])
        i += 1
        teamRaptors.append(firstRange[i])
        i += 1
    }
    
    // distribute medium height range across teams
    for _ in 1..<secondRange.count-1 {
        var i = thirds
        teamSharks.append(secondRange[i])
        i += 1
        teamDragons.append(secondRange[i])
        i += 1
        teamRaptors.append(secondRange[i])
        i += 1
    }

    // distribute high height range across teams
    for _ in 1..<thirdRange.count-1 {
        var i = thirdRange.count*thirds - 1
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
        totalHeight += playerHeight
        }
    }
    
    let teamCount = Double(team.count)
    
    let averageHeight = totalHeight / teamCount
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



