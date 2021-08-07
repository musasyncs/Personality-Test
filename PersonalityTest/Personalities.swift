//
//  Personalities.swift
//  PersonalityTest
//
//  Created by Ewen on 2021/8/6.
//

import Foundation

struct Personality {
    let name: String
    let category: category
    let type: String
    let description: String
}

enum category {
    case Analysts
    case Diplomats
    case Sentinels
    case Explorers
}

let personalities = [
    Personality(name: "Architect", category: .Analysts, type: "INTJ", description: "Imaginative and strategic thinkers, with a plan for everything."),
    Personality(name: "Logician", category: .Analysts, type: "INTP", description: "Innovative inventors with an unquenchable thirst for knowledge."),
    Personality(name: "Commander", category: .Analysts, type: "ENTJ", description: "Bold, imaginative and strong-willed leaders, always finding a way – or making one."),
    Personality(name: "Debater", category: .Analysts, type: "ENTP", description: "Smart and curious thinkers who cannot resist an intellectual challenge."),
    
    Personality(name: "Advocate", category: .Diplomats, type: "INFJ", description: "Quiet and mystical, yet very inspiring and tireless idealists."),
    Personality(name: "Mediator", category: .Diplomats, type: "INFP", description: "Poetic, kind and altruistic people, always eager to help a good cause."),
    Personality(name: "Protagonist", category: .Diplomats, type: "ENFJ", description: "Charismatic and inspiring leaders, able to mesmerize their listeners."),
    Personality(name: "Campaigner", category: .Diplomats, type: "ENFP", description: "Enthusiastic, creative and sociable free spirits, who can always find a reason to smile."),
    
    Personality(name: "Logistician", category: .Sentinels, type: "ISTJ", description: "Practical and fact-minded individuals, whose reliability cannot be doubted."),
    Personality(name: "Defender", category: .Sentinels, type: "ISFJ", description: "Very dedicated and warm protectors, always ready to defend their loved ones."),
    Personality(name: "Executive", category: .Sentinels, type: "ESTJ", description: "Excellent administrators, unsurpassed at managing things – or people."),
    Personality(name: "Consul", category: .Sentinels, type: "ESFJ", description: "Extraordinarily caring, social and popular people, always eager to help."),
    
    Personality(name: "Virtuoso", category: .Explorers, type: "ISTP", description: "Bold and practical experimenters, masters of all kinds of tools."),
    Personality(name: "Adventurer", category: .Explorers, type: "ISFP", description: "Flexible and charming artists, always ready to explore and experience something new."),
    Personality(name: "Entrepreneur", category: .Explorers, type: "ESTP", description: "Smart, energetic and very perceptive people, who truly enjoy living on the edge."),
    Personality(name: "Entertainer", category: .Explorers, type: "ESFP", description: "Spontaneous, energetic and enthusiastic people – life is never boring around them.")
]
