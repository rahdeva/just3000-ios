import Foundation
import Observation

@Observable
final class SettingViewModel {
    var dailyGoal: Int = 20
    var reminderEnabled: Bool = true
    var icloudEnabled: Bool = true
    var streak: Int = 7
    var longest: Int = 14
    var xp: Int = 3740
    var showResetAlert: Bool = false
}
