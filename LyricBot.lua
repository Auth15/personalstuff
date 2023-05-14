local GameInstance = game 

local HttpService = GameInstance:GetService("HttpService")
local ReplicatedStorage = GameInstance:GetService("ReplicatedStorage") 

local RobloxChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") 
local MsgRemote = RobloxChatEvents:FindFirstChild("SayMessageRequest")

Title  = string.gsub(Title, " ", "")
Artist = string.gsub(Artist, " ", "")
 
local SongData = HttpService:JSONDecode(game:HttpGet("https://lyrist.vercel.app/api/" .. Title .. "/" .. Artist))

if SongData.artist and SongData.title then 
	local Lyrics = {} 
	for Line in string.gmatch(SongData.lyrics, "") do 
		table.insert(Lyrics, Line)
	end
	
	for i, Line in pairs(Lyrics) do 
		MsgRemote:FireServer(Line, "All")
		wait(MsgDelay)
	end
else
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Lyrist",
		Text = "Lyrics not found for specified song and artist",
		Duration = 5 
	})
end 
