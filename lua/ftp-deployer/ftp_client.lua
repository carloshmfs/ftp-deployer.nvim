local FtpClient = {}

local lftp = require("ftp-deployer.lftp")
local config = require("ftp-deployer.config")

function FtpClient:download(file)
    config:new()
    config:init()

    local lftp_ob = lftp.new(config.host, config.port, config.user, config.password)

    lftp_ob:get(config.base_remote_path .. "/" .. file)
end

function FtpClient:upload(file)
end

return FtpClient
