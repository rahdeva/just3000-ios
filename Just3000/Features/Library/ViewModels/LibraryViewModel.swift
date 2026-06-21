import Foundation
import Observation
import SwiftUI

// MARK: - WordStage SwiftUI colors
extension WordStage {
    var color: Color {
        switch self {
        case .new:      return Color(red: 142/255, green: 142/255, blue: 147/255)
        case .learning: return Color(red: 255/255, green: 149/255, blue: 0)
        case .young:    return Color(red: 0,       green: 122/255, blue: 1)
        case .mature:   return Color(red: 175/255, green: 82/255,  blue: 222/255)
        case .mastered: return Color(red: 52/255,  green: 199/255, blue: 89/255)
        }
    }

    var backgroundColor: Color {
        color.opacity(self == .new ? 0.14 : 0.12)
    }
}

// MARK: - LibraryWord
struct LibraryWord: Identifiable {
    let id = UUID()
    let rank: Int
    let word: String
    let pos: String
    let ipa: String
    let definition: String
    let altDefinition: String?
    let translation: String?
    let translationDef: String?
    let example1: String
    let example2: String?
    let translationExample: String?
    var stage: WordStage
}

// MARK: - LibraryFilter
enum LibraryFilter: String, CaseIterable {
    case all = "All"
    case inProgress = "In Progress"
    case mastered = "Mastered"
}

// MARK: - LibrarySort
enum LibrarySort {
    case byRank, alphabetical
}

// MARK: - LibraryViewModel
@Observable
final class LibraryViewModel {
    let words: [LibraryWord] = [
        LibraryWord(rank: 1,  word: "the",     pos: "article",     ipa: "/ðə/",    definition: "Used to refer to a specific person or thing previously mentioned or known.", altDefinition: nil,                            translation: "yang / itu",       translationDef: "Digunakan untuk merujuk pada orang atau hal yang spesifik.",       example1: "The sun rises in the east.",        example2: "Can you pass the salt?",         translationExample: "Matahari terbit di timur.",            stage: .mastered),
        LibraryWord(rank: 2,  word: "be",      pos: "verb",        ipa: "/biː/",   definition: "To exist; to have a particular quality, characteristic, or state.",       altDefinition: "Used as an auxiliary verb.", translation: "adalah / menjadi", translationDef: "Menyatakan keberadaan atau suatu keadaan.",                        example1: "I want to be a doctor.",            example2: "She will be here soon.",          translationExample: "Saya ingin menjadi dokter.",           stage: .mastered),
        LibraryWord(rank: 3,  word: "to",      pos: "preposition", ipa: "/tuː/",   definition: "Expressing motion in the direction of a particular location.",            altDefinition: nil,                            translation: "ke / untuk",       translationDef: "Menyatakan arah atau tujuan.",                                    example1: "I'm going to school.",              example2: "She gave a gift to him.",         translationExample: "Saya pergi ke sekolah.",               stage: .mature),
        LibraryWord(rank: 4,  word: "of",      pos: "preposition", ipa: "/ɒv/",    definition: "Expressing the relationship between a part and a whole.",                 altDefinition: nil,                            translation: "dari / milik",     translationDef: "Menyatakan hubungan kepemilikan atau bagian dari sesuatu.",       example1: "A cup of tea.",                     example2: "The color of the sky is blue.",   translationExample: "Secangkir teh.",                       stage: .young),
        LibraryWord(rank: 5,  word: "and",     pos: "conjunction", ipa: "/ænd/",   definition: "Used to connect words, phrases, or clauses of the same grammatical type.", altDefinition: nil,                           translation: "dan",              translationDef: "Digunakan untuk menghubungkan kata atau frasa.",                  example1: "Salt and pepper go well together.", example2: "She sang and danced all night.",  translationExample: "Garam dan merica cocok bersama.",      stage: .learning),
        LibraryWord(rank: 6,  word: "a",       pos: "article",     ipa: "/eɪ/",    definition: "Used when referring to someone or something for the first time.",          altDefinition: nil,                            translation: "sebuah / seorang", translationDef: "Digunakan saat menyebut sesuatu untuk pertama kali.",             example1: "I saw a dog in the park.",          example2: "She is a talented teacher.",      translationExample: "Saya melihat seekor anjing di taman.", stage: .mastered),
        LibraryWord(rank: 7,  word: "in",      pos: "preposition", ipa: "/ɪn/",    definition: "Expressing the situation of being enclosed or surrounded by something.",   altDefinition: nil,                            translation: "di dalam / dalam", translationDef: "Menyatakan keberadaan di dalam sesuatu.",                         example1: "The keys are in the drawer.",       example2: nil,                               translationExample: "Kunci ada di dalam laci.",             stage: .mature),
        LibraryWord(rank: 8,  word: "that",    pos: "conjunction", ipa: "/ðæt/",   definition: "Used to identify a specific thing or person mentioned.",                   altDefinition: "Introducing a subordinate clause.", translation: "bahwa / itu",  translationDef: "Digunakan untuk mengidentifikasi hal tertentu.",                  example1: "She said that she was tired.",      example2: "That is my car.",                 translationExample: "Dia berkata bahwa dia lelah.",         stage: .young),
        LibraryWord(rank: 9,  word: "have",    pos: "verb",        ipa: "/hæv/",   definition: "To possess, own, or hold something.",                                      altDefinition: "Used as auxiliary for perfect tenses.", translation: "memiliki / punya", translationDef: "Memiliki atau mempunyai sesuatu.",                         example1: "I have two cats at home.",          example2: "Have you eaten lunch yet?",       translationExample: "Saya memiliki dua kucing di rumah.",   stage: .learning),
        LibraryWord(rank: 10, word: "it",      pos: "pronoun",     ipa: "/ɪt/",    definition: "Used to refer to a thing previously mentioned or easily identified.",      altDefinition: nil,                            translation: "itu / nya",        translationDef: "Merujuk pada benda yang sudah disebutkan sebelumnya.",            example1: "Where is it?",                      example2: "It is raining outside.",          translationExample: "Di mana itu?",                         stage: .mastered),
        LibraryWord(rank: 11, word: "for",     pos: "preposition", ipa: "/fɔːr/",  definition: "Indicating the purpose or intended destination of an action.",             altDefinition: nil,                            translation: "untuk / bagi",     translationDef: "Menunjukkan tujuan atau penerima yang dimaksud.",                 example1: "This gift is for you.",             example2: "We waited for an hour.",          translationExample: "Hadiah ini untuk kamu.",               stage: .new),
        LibraryWord(rank: 12, word: "not",     pos: "adverb",      ipa: "/nɒt/",   definition: "Used to make a clause, sentence, or word negative.",                       altDefinition: nil,                            translation: "tidak / bukan",    translationDef: "Digunakan untuk membuat kalimat negatif.",                        example1: "I am not ready for this.",          example2: "She did not come to the party.",  translationExample: "Saya tidak siap untuk ini.",           stage: .new),
        LibraryWord(rank: 13, word: "on",      pos: "preposition", ipa: "/ɒn/",    definition: "Physically in contact with and supported by a surface.",                   altDefinition: nil,                            translation: "di / pada",        translationDef: "Berada di atas atau pada suatu permukaan.",                       example1: "The book is on the table.",         example2: "He put the bag on the floor.",    translationExample: "Buku itu ada di atas meja.",           stage: .new),
        LibraryWord(rank: 14, word: "with",    pos: "preposition", ipa: "/wɪð/",   definition: "Accompanied by; in the company of.",                                       altDefinition: nil,                            translation: "dengan / bersama", translationDef: "Bersama dengan seseorang atau sesuatu.",                          example1: "She came with her best friend.",    example2: nil,                               translationExample: "Dia datang bersama teman baiknya.",    stage: .new),
        LibraryWord(rank: 15, word: "he",      pos: "pronoun",     ipa: "/hiː/",   definition: "Used to refer to a male person or animal previously mentioned.",           altDefinition: nil,                            translation: "dia (laki-laki)",  translationDef: "Merujuk pada seseorang atau hewan jantan.",                       example1: "He is my older brother.",           example2: nil,                               translationExample: "Dia adalah kakak laki-laki saya.",     stage: .new),
        LibraryWord(rank: 16, word: "as",      pos: "conjunction", ipa: "/æz/",    definition: "Used to indicate simultaneous occurrence or comparison.",                   altDefinition: "To the same degree.",          translation: "sebagai / seperti",translationDef: "Digunakan untuk menunjukkan perbandingan atau peran.",            example1: "She works as a nurse.",             example2: "He ran as fast as he could.",     translationExample: "Dia bekerja sebagai perawat.",         stage: .new),
        LibraryWord(rank: 17, word: "you",     pos: "pronoun",     ipa: "/juː/",   definition: "Used to refer to the person or people being addressed.",                    altDefinition: nil,                            translation: "kamu / Anda",      translationDef: "Merujuk pada orang yang sedang diajak bicara.",                   example1: "Are you ready to go?",             example2: nil,                               translationExample: "Apakah kamu siap pergi?",              stage: .new),
        LibraryWord(rank: 18, word: "do",      pos: "verb",        ipa: "/duː/",   definition: "To perform, carry out, or undertake an action or task.",                   altDefinition: "Used as an auxiliary in questions.", translation: "melakukan",   translationDef: "Melakukan atau menjalankan suatu tindakan.",                      example1: "I do my homework every night.",     example2: "Do you like coffee?",             translationExample: "Saya mengerjakan PR setiap malam.",    stage: .new),
        LibraryWord(rank: 19, word: "at",      pos: "preposition", ipa: "/æt/",    definition: "Expressing a precise point in time or location.",                          altDefinition: nil,                            translation: "di / pada",        translationDef: "Menyatakan suatu titik dalam ruang atau waktu.",                  example1: "I'll meet you at the park.",        example2: "She arrived at noon.",            translationExample: "Saya akan menemuimu di taman.",        stage: .new),
        LibraryWord(rank: 20, word: "this",    pos: "determiner",  ipa: "/ðɪs/",   definition: "Used to identify a specific person or thing close at hand.",               altDefinition: nil,                            translation: "ini",              translationDef: "Digunakan untuk mengidentifikasi sesuatu yang dekat.",            example1: "This is my house.",                example2: "I love this song.",               translationExample: "Ini adalah rumah saya.",               stage: .new),
    ]

    var masteredCount: Int {
        words.filter { $0.stage == .mastered }.count
    }

    func filtered(search: String, filter: LibraryFilter, sort: LibrarySort) -> [LibraryWord] {
        let q = search.trimmingCharacters(in: .whitespaces).lowercased()
        if !q.isEmpty {
            return words
                .filter { $0.word.lowercased().contains(q) }
                .sorted {
                    let ap = $0.word.lowercased().hasPrefix(q)
                    let bp = $1.word.lowercased().hasPrefix(q)
                    if ap != bp { return ap }
                    return $0.rank < $1.rank
                }
        }
        var result = words.filter {
            switch filter {
            case .all:        return true
            case .inProgress: return $0.stage != .new && $0.stage != .mastered
            case .mastered:   return $0.stage == .mastered
            }
        }
        switch sort {
        case .byRank:       result.sort { $0.rank < $1.rank }
        case .alphabetical: result.sort { $0.word < $1.word }
        }
        return result
    }
}
