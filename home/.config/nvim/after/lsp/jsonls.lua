return {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            format = { enable = true },
            validate = { enable = true },
        },
    },
}
