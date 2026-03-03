vim.filetype.add({
    extension = {
        grit = "gritql",
        pest = "pest",
        tf = "terraform",
        tfvars = "terraform",
    },
    filename = {
        [".envrc"] = "sh",
    },
})
