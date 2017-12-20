# MCMessaging
A RESTful way to send messages to other computers (ComputerCraft and OpenComputers)

External Libraries/Services Used:

- [PHPUtils](https://github.com/gknova61/PHPUtils) (all around personal library)

## Getting Started
A LAMP setup is preferred, but you will need a server running PHP 5.6, and MySQL at a minimum.

1. Refer to [`/config/config.php`](https://github.com/gknova61/MCMessaging/blob/master/config/config.php) to input MySQL credentials.
2. Refer to the [`/mysql`](https://github.com/gknova61/MCMessaging/blob/master/mysql) folder for table setups within mcmessaging schema. Run the [`/mysql/createSchema.sql`](https://github.com/gknova61/MCMessaging/blob/master/mysql/createSchema.sql) file first, then run [`/mysql/createTables.sql`](https://github.com/gknova61/MCMessaging/blob/master/mysql/createTables.sql) to create the necessary tables.

The MySQL user only needs SELECT, INSERT, UPDATE, and DELETE privileges on the mcmessaging schema.

### Limitations:
For performance reasons, messages can only be up to 200 characters in length.