# MCMessaging
Ever feel RedNet is insecure?
Use MCMessaging and stop worrying about those wannabe hackers!

This is a platform to send messages to other computers over HTTP (ComputerCraft and OpenComputers).

External Libraries/Services Used:

- [PHPUtils](https://github.com/gknova61/PHPUtils) (all around personal library)

## Setup
A LAMP setup is preferred, but you will need a server running PHP 5.6, and MySQL at a minimum.

1. Refer to [`/config/config.php`](https://github.com/gknova61/MCMessaging/blob/master/config/config.php) to input MySQL credentials.
2. Refer to the [`/mysql`](https://github.com/gknova61/MCMessaging/blob/master/mysql) folder for table setups within mcmessaging schema. Run the [`/mysql/createSchema.sql`](https://github.com/gknova61/MCMessaging/blob/master/mysql/createSchema.sql) file first, then run [`/mysql/createTables.sql`](https://github.com/gknova61/MCMessaging/blob/master/mysql/createTables.sql) to create the necessary tables.

The MySQL user only needs SELECT, INSERT, and UPDATE privileges on the mcmessaging schema.


## Getting Started (OpenComputers)
1. Put [`/lua/OpenComputers/messages.lua`](https://github.com/gknova61/MCMessaging/blob/master/lua/OpenComputers/messages.lua) and [`/lua/OpenComputers/example`](https://github.com/gknova61/MCMessaging/blob/master/lua/OpenComputers/example) in the same directory on an OpenComputer
2. Run and experiment with the example program

## Lua Implementation Docs:
  `local message = require("message")` for OpenComputers, or `os.loadAPI("message.lua")` for ComputerCraft
  - `message.setVerbose(bool)` - Whether or not to print out debug statements as to why a function returned false, default: true
  - `message.setLogin(id,password)` - Sets login credentials to use in sending/receiving messages. This doesn't validate them.
  - `message.getID()` - Returns a valid, and unused ID to register a new computer with
  - `message.register(id,password)` - Registers a new computer. Returns bool if successful or not
  - `message.send(toId,message)` - Sends a message to another id. Returns bool if successful or not
  - `message.getUnreadMessages()` - Returns a table containing all unread messages, or false if there are none

## Planned Additions (in order of priority):
    1. Sockets to receive, similar behavior to rednet.receive() in ComputerCraft
    2. ComputerCraft implementation

## Limitations:
For performance reasons, messages can only be up to 200 characters in length.
