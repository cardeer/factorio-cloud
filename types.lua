---@class Cloud.StorageDetail
---@field name string
---@field count? number
---@field quality? string

---@class Cloud.Storage
---  { [string] : Cloud.StorageDetail[]}

---@class Cloud.Player
---@field gui any
---@field quality_filtered string

---@class Downloader
--- { [integer] : Downloader.Filtered}

---@class Downloader.Filtered
---@field filter string | nil
---@field quality string
