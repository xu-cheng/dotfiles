return {
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            completion = true,
            format = { enable = true },
            hover = true,
            keyOrdering = false,
            validate = true,
            -- https://github.com/b0o/SchemaStore.nvim#usage
            schemaStore = {
                -- Must disable built-in schemaStore support to use schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    },
}
