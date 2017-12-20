<?php
/**
 * File Name: genID.php
 * Purpose: Generates an unused ID for a computer to register, if they want to
 *
 * Username: gknova61
 * Full Name: Keanu Kauhi-Correia
 * Email: keanu.kkc@gmail.com
 * Project: MCMessaging
 */

require_once('config/config.php');
require_once('libs/phputils/php/phputils.class.php');
require_once('libs/userHandler/php/loginHandler.class.php');

$con = MySQLConnect();

$firstRun = true;
while((query("SELECT id FROM users WHERE id='$id'")) || ($firstRun)) {
    $id = uniqid("gk") . '-' . uniqid("nov") . '-' . uniqid("a61");
    $firstRun = false;
}
echo $id;
closeScript();