local GameInstance = game 

local HttpService = GameInstance:GetService("HttpService")
local ReplicatedStorage = GameInstance:GetService("ReplicatedStorage") 

local RobloxChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") 
local MsgRemote = RobloxChatEvents:FindFirstChild("SayMessageRequest")

if not getgenv().SingToggled then 
	return 
end 

Title  = string.gsub(Title, " ", "")
Artist = string.gsub(Artist, " ", "")
 
local SongData = HttpService:JSONDecode(game:HttpGet("https://lyrist.vercel.app/api/" .. Title .. "/" .. Artist))

if SongData.artist and SongData.title then 
	local Lyrics = {} 
	for Line in string.gmatch(SongData.lyrics, "[^\n]+") do 
		table.insert(Lyrics, Line)
	end
	
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Lyrist",
		Text = "Singing " .. SongData.title .. " by " .. SongData.artist,
		Duration = 5
	})
	
	for i, Line in pairs(Lyrics) do 
		if not getgenv().SingToggled then continue end 
		MsgRemote:FireServer(Line, "All")
		wait(MsgDelay)
	end
else
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Lyrist",
		Text = "Lyrics not found for specified song and artist",
		Duration = 10 
	})
end 
