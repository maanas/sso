<?php
/* Session Handler for PHP
 * Overrides the default session mechanism
 * Needs to be called prior to session_start()
 */
/**
 *
 * @author Maanas Royy <maanas@maanas.co>
 * @copyright Maanas Network 
 *
 * @version 1.2.1
 *
 *
 **/

/*
 * Set Session Handler
 */ 
session_set_save_handler('_open', '_close', '_read', '_write', '_destroy', '_clean');


/* 
 * Open Handler for Session
 */
function _open(){
    global $_sess_db;
    if ($_sess_db = mysql_connect('127.0.0.1', 'database-username', 'database-password')) {
        return mysql_select_db('sso', $_sess_db);
    }
    return FALSE;
}

/* 
 * Close Handler for Session
 */
function _close(){
    global $_sess_db;
    return mysql_close($_sess_db);
}

/* 
 * Read Handler for Session
 */
function _read($id){
    global $_sess_db;
 
    $id = mysql_real_escape_string($id);
 
    $sql = "SELECT s_data
            FROM   session
            WHERE  s_token = '$id'";
 
    if ($result = mysql_query($sql, $_sess_db)) {
        if (mysql_num_rows($result)) {
            $record = mysql_fetch_assoc($result);
            return unserialize($record['s_data']);
        }
    }
    return '';
}

/* 
 * Write Handler for Session
 */
function _write($id, $data){
    global $_sess_db;
 
    $access = time();
    $id = mysql_real_escape_string($id);
    $access = mysql_real_escape_string($access);
    $data = mysql_real_escape_string(serialize($data));
 
    $sql = "REPLACE
            INTO    session (s_token, s_lastaccess, s_data)
            VALUES  ('$id', '$access', '$data')";
 
    return mysql_query($sql, $_sess_db);
}

/* 
 * Destroy Handler for Session
 */
function _destroy($id){
    global $_sess_db;
 
    $id = mysql_real_escape_string($id);
 
    $sql = "DELETE
            FROM   session
            WHERE  s_token = '$id'";
 
    return mysql_query($sql, $_sess_db);
} 


/* 
 * Clean Handler for Session
 */
function _clean($max)
{
    global $_sess_db;
 
    $old = time() - $max;
    $old = mysql_real_escape_string($old);
 
    $sql = "DELETE
            FROM   session
            WHERE  s_lastaccess < '$old'";
 
    return mysql_query($sql, $_sess_db);
}


