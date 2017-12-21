local internet = require("internet")
local JSON = require("json")

local verbose = true
local host = "http://192.241.212.78"
local isLoginSet = false
local id = ""
local password = ""

local message = {}

-- Helper for fetching page content from the internet. All you need to do is change this function for other computer mods
function message.getInetPageContent(url,postDataTable)
    content = ""
    if not postDataTable then
        for line in internet.request(url) do
            content = content .. line
        end
    else
        for line in internet.request(url, postDataTable) do
            content = content .. line
        end
    end
    return content
end

-- Set the message server on-the-fly
function message.setServer(newHost)
    host = newHost
end

-- Getter for checking if login credentials are set
function message.isLoginSet()
    return isLoginSet
end

-- Set login credentials to be used in send and receive functions, will not be validated
function message.setLogin(idLogin,passwordLogin)
    isLoginSet = true
    password = passwordLogin
    id = idLogin
end

-- Prints debug statements when something goes wrong
function message.setVerbose(isVerbose)
    verbose = isVerbose
end

-- Gets an unused, valid ID for you to register a new computer with
function message.getID()
    return message.getInetPageContent(host .. "/genID.php")
end

-- Registers computer, returns false on error
function message.register(id,password)
    content = message.getInetPageContent(host .. "/registerComputer.php",{id = id, password = password})
    if(content == "success") then
        return true
    else
        if(verbose) then
            print(content)
        end
        return false
    end
end

-- Sends a message to another computer
function message.send(toId,message)
    if not isLoginSet then
        if(verbose) then
            print("Login credentials not set")
        end
        return false
    end

    content = message.getInetPageContent(host .. "/send.php", {id = id, password = password, to = toId, message = message})
    if content == "success" then
        return true
    else
        if(verbose) then
            print(line)
        end
        return false
    end
end

--Will get the most recently non-accessed message(s). Return false if nothing
function message.getUnreadMessages()
    if not isLoginSet then
        if(verbose) then
            print("Login credentials not set")
        end
        return false
    end

    content = message.getInetPageContent(host .. "/getUnreadMessages.php", {id = id, password = password,})
    if((line == "false") or (line == "Invalid ID/Password")) then
        if((verbose) and (line == "Invalid ID/Password")) then
            print(line)
        end
        return false
    else
        return JSON:decode(content)
    end
end

--Will open TCP socket to recieve messages (TBD)
function message.recieve()
end

return message
