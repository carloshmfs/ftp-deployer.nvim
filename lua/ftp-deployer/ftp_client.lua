local FtpClient = {}

local json = require("libs.json")
local lftp = require("ftp-deployer.lftp")
local config = require("ftp-deployer.config")

local CONFIG_FILE_NAME = "ftp-deployer.json"

local function get_config()
    local file_path = vim.loop.cwd() .. "/" .. CONFIG_FILE_NAME
    local file = io.open(file_path, "r")

    if file == nil then
        print("config file not found")
        return {}
    end

    local file_contents = ""
    for line in file:lines() do
        file_contents = file_contents .. line
    end

    return json.decode(file_contents) or nil
end

local function spawn_lftp(cmd)
    local config = get_config()

    local lftp_cmd = "lftp -e 'set ssl:verify-certificate no; open ftp://" ..
        config.user .. ":" .. config.password .. "@" .. config.host .. "; " .. cmd .. " '"

    print(lftp_cmd)
end

function FtpClient:download(file)
    config:new()
    config:init()

    local lftp_ob = lftp.new(config.host, config.port, config.user, config.password)

    lftp_ob:get(config.base_remote_path .. "/" .. file)
end

function FtpClient:upload(file)
    local config = get_config()
    if not config then
        print("[FtpDeployer] ERROR: config file not found.")
        return
    end

    local path = config.base_remote_path .. file
end

return FtpClient
