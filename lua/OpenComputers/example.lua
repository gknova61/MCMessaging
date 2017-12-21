local message = require("message")
local id = ""
local password = ""
message.setVerbose(true)

-- Helper function for getting a yes or no decision from the user
local function getYesOrNoFromUser(question)
    decision = true
    while(true) do
        print(question)
        decisionFromUser = io.read()
        if(decisionFromUser:lower() == "y") then
            break
        elseif(decisionFromUser:lower() == "n") then
            continue = false
            break
        else
            print("Oops, that doesn't look like correct input. Please enter y or n")
        end
    end
    return decision
end

while(true) do
    print("\nWelcome to the MCMessaging Example Program!")
    print("Please choose from the following options:")
    print("1. Register new Computer")
    print("2. Set login with existing credentials")
    print("3. Send a message to another computer")
    print("4. Check for unread messages")
    print("5. Exit")

    print("Please enter an option (1-5):")
    optionFromUser = io.read()

    print()

    if(optionFromUser == "1") then -- Register
        local continue = true
        if(id ~= "") then
            decision = getYesOrNoFromUser("It looks like you've already got login credentials set. Are you sure you want to clear them? (y/n):")
            if not decision then continue = false end
        end

        if(continue) then
            decision = getYesOrNoFromUser("Would you like to autogenerate an ID? (y/n)")
            if not decision then
                print("Please enter a valid ID: ")
                idTemp = io.read()
            else
                idTemp = message.getID()
                print("Your ID is: "..idTemp)
            end

            print("Please enter a password: ")
            passwordTemp = io.read()

            if(message.register(idTemp,passwordTemp)) then
                print("Success")
                id = idTemp
                password = passwordTemp
                message.setLogin(id,password)
            else
                print("Error occured on registering a new computer")
            end
        end
    elseif(optionFromUser == "2") then -- Set Login Credentials
        print("NOTE: This will not be validated until you try to send/fetch messages")
        print("Please enter id: ")
        id = io.read()
        print("Please enter password: ")
        password = io.read()
        message.setLogin(id,password)
        print("Login set")
    elseif(optionFromUser == "3") then -- Send Message
        if(message.isLoginSet()) then
            print("Please enter the ID you'd like to send a message to: ")
            to = io.read()
            print("Please enter the message you'd like to send (up to 200chars): ")
            messageToSend = io.read()

            if(message.send(to,messsageToSend)) then
                print("Success")
            else
                print("An error occured on sending message")
            end
        else
            print("ERROR: You need to either set a login, or register this computer before sending a message")
        end
    elseif(optionFromUser == "4") then -- Check for unread messages
        if(message.isLoginSet()) then
            newMessages = message.getUnreadMessages()
            if(not newMessages) then
                print("No new messages")
            else
                print(newMessages)
            end
        else
            print("ERROR: You need to either set a login, or register this computer before checking your messages")
        end
    elseif(optionFromUser == "5") then -- Exit
        break
    else
        print("That doesn't seem like a valid input, please enter a number between 1 and 5 (inclusive)")
    end

    os.sleep(2)
end
