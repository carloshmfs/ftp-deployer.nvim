---@class LFTP
---@field host string
---@field port string
---@field user string
---@field password string
local LFTP = {}

LFTP.__index = LFTP

---@param cmd string
---@param host string
---@param user string
---@param password table
local function make_cmd(cmd, host, user, password)
    return {
        "lftp",
        "-e",
        "'set ssl:verify-certificate no; open ftp://" .. user .. ":" .. password .. "@" .. host .. "; " .. cmd .. " '",
    }
end

function LFTP.new(host, port, user, password)
    return setmetatable({
        host = host,
        port = port,
        user = user,
        password = password
    }, LFTP)
end

function LFTP:put()
end

---@param remote_file string
---@return string
function LFTP:get(remote_file)
    local cmd     = make_cmd("cat " .. remote_file, self.host, self.user, self.password)
    local opts    = {
        -- text = true,
    }
    local on_exit = function(obj)
        if obj.code ~= 0 then
            -- vim.notify("[FtpDeployer] Could not launch the lftp process.", vim.log.levels.ERROR)
            print("[FtpDeployer] Could not launch the lftp process.")
            return
        end

        local file_contents = obj.stdout
    end

    vim.system(cmd, opts, on_exit)

    return ""
end

function LFTP:cat()
end

return LFTP
