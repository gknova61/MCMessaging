<?php
/**
 * File Name: registerComputer.php
 * Purpose: Frontend for computer registration
 *
 * Username: gknova61
 * Full Name: Keanu Kauhi-Correia
 * Email: keanu.kkc@gmail.com
 * Project: MCMessaging
 */
require_once('config/config.php');
require_once('libs/phputils/php/phputils.class.php');
require_once('libs/userHandler/php/loginHandler.class.php');

if((!intval($_POST['id'])) || (!$_POST['password'])) {
    closeScript('Missing ID/Password');
}

if((strlen($_POST['password']) < 8) || (!preg_match('~[0-9]~',$_POST['password']))) {
    closeScript('Password must be at least 8 characters long and have at least one number');
}
$con = MySQLConnect();

if(registerComputer($_POST['id'],$_POST['password'])) {
    echo "success";
}else {
    echo "ID already exists";
}

