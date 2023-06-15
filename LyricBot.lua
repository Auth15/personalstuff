local GameInstance = game; 

local HttpService = GameInstance:GetService("HttpService");
local ReplicatedStorage = GameInstance:GetService("ReplicatedStorage"); 

local RobloxChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents"); 
local MsgRemote = RobloxChatEvents:FindFirstChild("SayMessageRequest"); 

if not getgenv().SingToggled then return end 

getgenv().SaySpeed = getgenv().SaySpeed or 2.5  

Title  = string.gsub(Title, " ", "");
Artist = string.gsub(Artist, " ", "");

local SongJSON = HttpService:JSONDecode(game:HttpGet("https://lyrist.vercel.app/api/" .. Title .. "/" .. Artist)); 

if SongJSON.artist and SongJSON.title then 
	for Line in string.gmatch(SongJSON.lyrics, "[^\n]+") do 
		if not getgenv().SingToggled then break end 
		MsgRemote:FireServer(Line, "All");
		wait(SaySpeed);
	end
else
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Lyrist",
		Text = "Lyrics not found for the specified artist and title",
		Duration = 10 
	});
end 
