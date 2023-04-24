--- ===ConfigReloader===
---
--- Reloads hammerspoon configuration whenever a file changes
---

local obj = {}
setmetatable(obj, obj)

-- Metadata
obj.name = "ConfigReloader"
obj.version = "0.0.2"
obj.author = "Neta Elad <elad.neta@gmail.com>"
obj.homepage = "https://github.com/netaelad/ConfigReloader.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Local
local function reloadConfig(changedFiles)
    local doReload = false
    for _, file in pairs(changedFiles) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- Public
function obj:init()
    self.watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
end

function obj:start()
    self.watcher:start()
end

function obj:stop()
    self.watcher:stop()
end

return obj