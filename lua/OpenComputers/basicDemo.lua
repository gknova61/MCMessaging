local message = require("message")
message.setServer("http://192.241.212.78")
message.setVerbose(true)
local firstPassword = "hello123"
local secondPassword = "hello1234"

local function pause()
    print("Hit Enter to Continue")
    io.read()
end

print("Registering first computer...\n")
firstID = message.getID()
assert(message.register(firstID,firstPassword),"Something went wrong registering the first computer!")
print("Registed the first computer as ID: "..firstID)

pause()

print("Registering second computer...\n")
secondID = message.getID()
assert(message.register(secondID,secondPassword),"Something went wrong registering the second computer!")
print("Registed the second computer as ID: "..secondID)

pause()

message.setLogin(firstID,firstPassword)

assert(message.send(secondID,"Hello World"),"Something went wrong sending a message to the second computer!")
print("Sent a message from the first computer, to the second computer\n")

pause()

print("Fetching message as second computer...")
message.setLogin(secondID,secondPassword)

newMessages = message.getUnreadMessages()
assert(newMessages,"Failed to fetch new messages!")

numOfMessages = 0
for messageNum,messageTable in pairs(newMessages) do
    numOfMessages = numOfMessages + 1
    print("Message #"..numOfMessages)
    print("From: "..messageTable["idFrom"])
    print("Message: "..messageTable["message"])
    print("Time Sent: "..messageTable["timeSent"])
    print()
end
print("Total New Messages: "..tostring(numOfMessages))