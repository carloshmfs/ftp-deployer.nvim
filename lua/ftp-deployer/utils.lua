local Utils = {}

function Utils:split_string(str, sep)
    print(str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for word in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, word)
    end
    return t
end

return Utils

