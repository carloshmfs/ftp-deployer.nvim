local LFTP = {}

LFTP.__index = LFTP

local function make_cmd(cmd, host, user, password)
    local lftp_cmd = "lftp -e 'set ssl:verify-certificate no; open ftp://" ..
        user .. ":" .. password .. "@" .. host .. "; " .. cmd .. " '"

    return lftp_cmd
end

function LFTP.new(host, port, user, password)
    local self = setmetatable({}, LFTP)
    self.host = host
    self.port = port
    self.user = user
    self.password = password
    return self
end

function LFTP:put()
end

function LFTP:get(remote_file)
    local cmd = make_cmd("cat " .. remote_file, self.host, self.user, self.password)
    print(cmd)
end

function LFTP:cat()
end

return LFTP
