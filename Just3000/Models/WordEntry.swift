import Foundation

struct WordEntry: Codable {
    let rank: Int
    let word: String
    let pos: String?
    let ipa: String?
    let def: String?
    let alt: String?
    let ex1: String?
    let ex2: String?
    let id_translation: String?
    let idDef: String?
    let idEx1: String?
}
