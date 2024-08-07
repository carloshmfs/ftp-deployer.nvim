local FtpClient = {}

local ftp = require("socket.ftp")

local config = {
    host = "ftp://test.rebex.net",
    user = "",
    password = "",
    base_path = "",
}

local function open_connection(file)
end

function FtpClient:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function FtpClient:download(file)
    -- local path = config.path .. "/" .. file

    print(self, file)

    -- local response = ftp.get({
    --     host = config.host,
    --     user = config.user,
    --     password = config.password,
    -- })
end

function FtpClient:upload(self, file)
end

return FtpClient

