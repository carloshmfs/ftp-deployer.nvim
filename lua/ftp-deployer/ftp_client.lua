local FtpClient = {}

function FtpClient:new(config)
    local self = setmetatable({}, FtpClient)
    self.config = config or {}

    return self
end

function FtpClient:download(file)
end

function FtpClient:upload(file)
    print(file)
end

function FtpClient:open_connection(file)
end

return FtpClient

