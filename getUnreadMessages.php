<?php
/**
 * File Name: getUnreadMessages.php
 * Purpose: Return a JSON array of all unread messages, or false if there isn't any new messages
 *
 * Username: gknova61
 * Full Name: Keanu Kauhi-Correia
 * Email: keanu.kkc@gmail.com
 * Project: MCMessaging
 */
require_once('config/config.php');
require_once('libs/phputils/php/phputils.class.php');
require_once('libs/userHandler/php/loginHandler.class.php');

if((!$_POST['id']) || (!$_POST['password'])) {
    closeScript('Missing ID/Password');
}else {
    $id = $_POST['id'];
    $passwordFromUser = $_POST['password'];
}

$con = MySQLConnect();

if(authenticateComputer($id,$passwordFromUser)) {
    echo json_encode(query("SELECT * FROM `messages` WHERE idTo='".mysqli_real_escape_string($con,$id). "' AND accessed IS NULL;"));
    query("UPDATE `messages` SET `accessed` = '". mysqli_real_escape_string($con,date('Y-m-d H:i:s', time())) ."' WHERE idTo='".mysqli_real_escape_string($con,$id). "' AND accessed IS NULL;");
}

closeScript();