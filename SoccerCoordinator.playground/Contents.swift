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


// sort each player group by height, one ascending and one descending, in preparation for height distribution
// this way the shortest and highest heights should end up on the same teams

var sortedExperienced = someExperience.sorted {(left: [String: String], right: [String: String]) -> Bool in
    guard let leftHeight = left[height], let doubledLeft = Double(leftHeight), let rightHeight = right[height], let doubledRight = Double(rightHeight) else {
        return false }
        return doubledLeft < doubledRight
    }

var sortedInexperienced = noExperience.sorted {(left: [String: String], right: [String: String]) -> Bool in
    guard let leftHeight = left[height], let doubledLeft = Double(leftHeight), let rightHeight = right[height], let doubledRight = Double(rightHeight) else {
        return false }
    return doubledLeft > doubledRight
}


// initialize empty arrays for teams

var teamSharks: [[String: String]] = []
var teamDragons: [[String: String]] = []
var teamRaptors: [[String: String]] = []


// put teams in array to prepare for distribution

var leagueTeams = [teamSharks, teamDragons, teamRaptors]


// function to distribute experienced and inexperienced groups to teams (which were previously sorted by height)

func dividePlayers(playerGroup: [[String: String]], teams: [[[String: String]]]) {
    
    var mutableTeams = teams // copy let from loop to variable
    var mutableGroup = playerGroup // copy let from loop to variable
    
    while mutableGroup.isEmpty == false { // proceed while playerGroup isn't empty
        for team in 0..<mutableTeams.count { // iterate through array of teams to assign players in sequence
            if mutableGroup.count == 0 {
                break // break out of loop if all playerGroup members have been assigned (prevents out of range error)
            } else {
                mutableTeams[team].append(mutableGroup[0]) // assign value to team from playerGroup array
                mutableGroup.remove(at: 0) // then remove value from playerGroup
            }
        }
    }
    
    teamSharks += mutableTeams[0] // add players to teams
    teamDragons += mutableTeams[1]
    teamRaptors += mutableTeams[2]
}


// call function to divide each group of players into teams

dividePlayers(playerGroup: sortedInexperienced, teams: leagueTeams)
dividePlayers(playerGroup: sortedExperienced, teams: leagueTeams)


// function to compute average height per team

func averageHeight(for team: [[String: String]]) -> Double {
    var totalHeight: Double = 0
    
    for player in team {
        if let playerHeight = player[height], let doublePlayerHeight = Double(playerHeight) { // prevent optional and cast type
        totalHeight += doublePlayerHeight // add all player heights together
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


// print heights to console

print("Raptors average height: \(teamRaptorsAverageHeight) \nDragons average height: \(teamDragonsAverageHeight) \nSharks average height: \(teamSharksAverageHeight) \n")


// iterate through players and create letters

var letters: [String] = [] // empty array to hold letters


// reusable function to generate letters with team and date inputs
func createLetters(team: [[String: String]], teamName: String, practiceDate: String) {
    
    for player in team {
        if let playerGuardian = player[guardians], let playerName = player[name] {
        let letter = "Dear \(playerGuardian), \n\nYour child, \(playerName), has been placed on the \(teamName) team for the soccer league. The \(teamName) have their first practice set for \(practiceDate), so please be certain that your child attends, has the proper equipment, and brings along lots of energy. It is very important that \(playerName) attend the practice, so be sure to mark the date and time on your calendars! \n\nWe look forward to seeing you there!\n"
        letters.append(letter)
        }
    }   
}

// call function to create letters

createLetters(team: teamRaptors, teamName: "Raptors", practiceDate: "March 18, 1pm")
createLetters(team: teamDragons, teamName: "Dragons", practiceDate: "March 17, 1pm")
createLetters(team: teamSharks, teamName: "Sharks", practiceDate: "March 17, 3pm")


// output letters to console
for letter in letters {
    print(letter)
}


