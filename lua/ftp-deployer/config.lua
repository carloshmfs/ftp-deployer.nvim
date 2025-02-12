local Config = {}

-- @type string
Config.CONFIG_FILE_NAME = "ftp-deployer.json"

local json = require("libs.json")

Config.host = nil
Config.port = nil
Config.user = nil
Config.password = nil
Config.base_local_path = nil
Config.base_remote_path = nil

function Config:new()
    setmetatable({}, Config)
    self.__index = self
end

function Config:init()
    local file_path = vim.loop.cwd() .. "/" .. self.CONFIG_FILE_NAME
    local file = io.open(file_path, "r")

    if file == nil then
        vim.notify("[FtpDeployer] config file not found", vim.log.levels.ERROR)
        return false
    end

    local file_contents = ""
    for line in file:lines() do
        file_contents = file_contents .. line
    end

    local contents = json.decode(file_contents)
    if contents == nil then
        vim.notify("[FtpDeployer] an error occurred while reading the config file", vim.log.levels.ERROR)
        return false
    end

    self.host = contents.host
    self.port = contents.port
    self.user = contents.user
    self.password = contents.password
    self.base_local_path = contents.base_local_path
    self.base_remote_path = contents.base_remote_path

    return true
end

return Config
