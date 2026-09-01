vim.filetype.add({
    extension = {
        gitconfig = "gitconfig",
        grit = "gritql",
        pest = "pest",
        tf = "terraform",
        tfvars = "terraform",
    },
    filename = {
        [".envrc"] = "sh",
    },
})
