-- Minimal verified-boombox: plays only IDs the rblxdb API confirms working.
local HttpService = game:GetService("HttpService")

local function getWorkingSongs(query)
	local url = "https://rblxdb.com/api/v1/songs?limit=25"
		.. (query and ("&q=" .. HttpService:UrlEncode(query)) or "")
	local ok, res = pcall(function() return HttpService:GetAsync(url) end)
	if not ok then return {} end
	local ok2, data = pcall(function() return HttpService:JSONDecode(res) end)
	if not ok2 or not data.songs then return {} end
	return data.songs
end

local sound = Instance.new("Sound")
sound.Parent = workspace
local songs = getWorkingSongs("phonk")
if #songs > 0 then
	sound.SoundId = "rbxassetid://" .. songs[1].id
	sound:Play()
end
