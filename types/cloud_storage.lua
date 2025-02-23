---@class Cloud.StorageDetail
---@field amount number
local CloudStorageDetail = {}

-- -- Constructor function (optional, but useful)
-- function CloudStorageDetail.new(name, amount)
--     local self = setmetatable({}, CloudStorageDetail)
--     self.amount = amount
--     return self
-- end

---@alias Cloud.Storage
---| { [string]: Cloud.StorageDetail }
local CloudStorage = {}
