<?php
/**
 * File Name: loginHandler.class.php
 * Purpose: Handle basic user interaction
 *
 * Username: gknova61
 * Full Name: Keanu Kauhi-Correia
 * Email: keanu.kkc@gmail.com
 * Project: MCMessaging
 */

/**
 * @brief checks the id and password against the database to see if auth'd user
 * @param $id
 * @param $passwordFromUser
 * @return true if the user is authenticated
 */
function authenticateComputer($id, $passwordFromUser) {
    global $con;
    $authenticated = false;

    $salt = @query("SELECT salt FROM users WHERE id='".mysqli_real_escape_string($con,$id). "'")[0]["salt"];
    $passwordFromUser = $salt . $passwordFromUser;
    $validPassword = query("SELECT password FROM users WHERE id='".mysqli_real_escape_string($con,$id). "'");
    if($validPassword) {
        if($validPassword[0]["password"] == hash('sha256', $passwordFromUser)) {
            $authenticated = true;
        }
    }
    return $authenticated;
}

/**
 * @brief Registers a user so they can send messages to others, ID must not already exist. Has no inherent password policy
 * @param $id
 * @param $passwordFromUser
 * @return true if user was created, false if already in db
 */
function registerComputer($id,$passwordFromUser) {
    global $con;
    
    $salt = bin2hex(random_bytes(5));
    $passwordFromUser = $salt . $passwordFromUser;
    $passwordFromUser = hash('sha256',$passwordFromUser);
    
    if(query("SELECT id FROM users WHERE id='$id'")) {
        return false;
    }else {
        query("INSERT INTO `mcmessaging`.`users`(`id`,`password`,`salt`,`ip`) VALUES ('".mysqli_real_escape_string($con,$id)."','".mysqli_real_escape_string($con,$passwordFromUser)."','".mysqli_real_escape_string($con,$salt)."','". mysqli_real_escape_string($con,get_client_ip()) ."');");
        return true;
    }
}

/**
 * @brief Checks if given ID is in a valid foramt
 * @param $idToValidate
 * @return bool if valid ID
 */
function isValidID($idToValidate) {
    $valid = true;
    if(strlen($idToValidate) != 49) {
        $valid = false;
    }else if(substr($idToValidate,0,2) != "gk") {
        echo substr($idToValidate,0,2);
        $valid = false;
    }else if(substr($idToValidate,16,3) != "nov") {
        echo substr($idToValidate,16,3);
        $valid = false;
    }else if(substr($idToValidate,33,3) != "a61") {
        echo substr($idToValidate,33,3);
        $valid = false;
    }
    return $valid;
}