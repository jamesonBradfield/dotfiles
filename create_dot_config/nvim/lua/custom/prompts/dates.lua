local today = os.date '%Y-%m-%d'
local tomorrow = os.date('%Y-%m-%d', os.time() + 86400)
local id = os.date '%Y%m%d%H%M'

return {
  today = today,
  tomorrow = tomorrow,
  id = id,
}
