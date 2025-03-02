---@class Cloud.StorageDetail
---@field name string
---@field count? number
---@field quality? string

---@class Cloud.Storage
---|  { [string] : Cloud.StorageDetail[]}

---@class Container.Filtered
---@field filter { [integer] : Cloud.StorageDetail}
---@field quality { [integer] : string}

---@class Cloud.Player
---@field gui any
---@field quality_filtered string
