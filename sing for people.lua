local GameInstance = game; 

local HttpService = GameInstance:GetService("HttpService");
local ReplicatedStorage = GameInstance:GetService("ReplicatedStorage"); 
local TextService = GameInstance:GetService("TextChatService"); 

local RobloxChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents"); 
local MsgRemote = RobloxChatEvents and RobloxChatEvents:FindFirstChild("SayMessageRequest"); 

if not getgenv().SingToggled then return end 

local function SendMessage(Msg)
	if TextService.ChatInputBarConfiguration.TargetTextChannel then 
		TextService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(Msg); 
	else
		MsgRemote:FireServer(Msg, "All"); 
	end; 
end; 

getgenv().SaySpeed = getgenv().SaySpeed or 2.5  

Title  = string.gsub(Title, " ", "");
Artist = string.gsub(Artist, " ", "");

local Result, SongJSON = game:HttpGet("https://lyrist.vercel.app/api/" .. Title .. "/" .. Artist); 
SongJSON = HttpService:JSONDecode(Result); 

if SongJSON.artist and SongJSON.title then 
	for Line in string.gmatch(SongJSON.lyrics, "[^\n]+") do 
		if not getgenv().SingToggled then break end 
		SendMessage(Line);
		wait(SaySpeed);
	end
else
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Lyrist",
		Text = "Lyrics not found for the specified title and artist",
		Duration = 10
	});
end 
