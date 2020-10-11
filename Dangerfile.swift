import Danger 
let danger = Danger()

SwiftLint.lint(inline: true)

// Pull out the edited files and find ones that come from a sub-folder
// where our app lives
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
let deletedFiles = danger.git.deletedFiles
let editedAppFiles = editedFiles.filter {
    ($0.fileType == .swift || $0.fileType == .m) && $0.contains("EventCountdown")
}

//editedFiles.forEach{danger.message("File: \($0) was edited")}
//editedAppFiles.forEach{danger.message("App file: \($0) was edited")}

// Let people bail from the CHANGELOG check
let hasSkipChangelog = danger.github.pullRequest.body?.contains("#no_changelog") ?? false
let hasSkipChangelogLabel = danger.github.issue.labels.first { $0.name == "Skip Changelog" }
let skipCheck = hasSkipChangelog || hasSkipChangelogLabel != nil

// Request for a CHANGELOG entry with each app change
if editedAppFiles.isEmpty && !skipCheck {
    fail("Please add a CHANGELOG entry for these changes. If you would like to skip this check, add `#no_changelog` to the PR body and re-run CI.")
}
