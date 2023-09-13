vim.filetype.add({
    extension = {
        tf = "terraform",
        tfvars = "terraform",
    },
    filename = {
        [".envrc"] = "sh",
    },
})
