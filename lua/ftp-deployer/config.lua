local Config = {}

local json = require("json")

Config.CONFIG_FILE_NAME = "ftp-deployer.json"

Config.host = nil
Config.port = nil
Config.user = nil
Config.password = nil
Config.base_local_path = nil
Config.base_remote_path = nil

function Config.setup()
    local file_path = vim.loop.cwd() .. "/" .. CONFIG_FILE_NAME
    local file = io.open(file_path, "r")

    if file == nil then
        vim.notify("[FtpDeployer] config file not found", vim.log.levels.ERROR)
        return
    end

    local file_contents = ""
    for line in file:lines() do
        file_contents = file_contents .. line
    end

    local contents = json.decode(file_contents)
    if contents == nil then
        vim.notify("[FtpDeployer] an error occurred while reading the config file", vim.log.levels.ERROR)
        return
    end

    Config.host = contents.host
    Config.port = contents.port
    Config.user = contents.user
    Config.password = contents.password
    Config.base_local_path = contents.base_local_path
    Config.base_remote_path = contents.base_remote_path
end

return Config
