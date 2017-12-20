<?php
/**
 * File Name: send.php
* Purpose: Store a message by an authenticated user in the MySQL database, for later retrieval
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

if((!$_POST['to']) || (!$_POST['message'])) {
    closeScript('Missing reciever/message');
}else {
    $to = $_POST['to'];
    $message = $_POST['message'];
}

if($id == $to) {
    closeScript('Sender and reciever ID are the same');
}

$con = MySQLConnect();

if(!query("SELECT id FROM users WHERE id='".mysqli_real_escape_string($con,$to). "'")) {
    closeScript('No reciever for \'to\' field');
}

if(authenticateComputer($id,$_POST['password'])) {
    query("INSERT INTO `mcmessaging`.`messages`(`message`,`idFrom`,`idTo`) VALUES ('".mysqli_real_escape_string($con,$message)."','".mysqli_real_escape_string($con,$id)."','".mysqli_real_escape_string($con,$to)."');");
    echo "success";
}else {
    closeScript("Invalid ID/Password");
}
?>