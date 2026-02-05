vim.filetype.add({
    extension = {
        grit = "gritql",
        tf = "terraform",
        tfvars = "terraform",
    },
    filename = {
        [".envrc"] = "sh",
    },
})
