import Danger 
let danger = Danger()

let editedFiles  = danger.git.modifiedFiles + danger.git.createdFiles
let deletedFiles = danger.git.deletedFiles

danger.message("Hello from Danger")
