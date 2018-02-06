<?php
/**
 * Wodby-specific configuration file.
 */

$wodby['base_url'] = '{{ getenv "BASE_URL" "" }}';

$wodby['db']['host'] = '{{ getenv "DB_HOST" "" }}';
$wodby['db']['name'] = '{{ getenv "DB_NAME" "" }}';
$wodby['db']['username'] = '{{ getenv "DB_USER" "" }}';
$wodby['db']['password'] = '{{ getenv "DB_PASSWORD" "" }}';
$wodby['db']['charset'] = '{{ getenv "DB_CHARSET" "utf8" }}';
$wodby['db']['collation'] = '{{ getenv "DB_COLLATION" "" }}';

$wodby['wp']['auth_key'] = '{{ getenv "WP_AUTH_KEY" "" }}';
$wodby['wp']['auth_salt'] = '{{ getenv "WP_AUTH_SALT" "" }}';
$wodby['wp']['secure_auth_key'] = '{{ getenv "WP_SECURE_AUTH_KEY" "" }}';
$wodby['wp']['secure_auth_salt'] = '{{ getenv "WP_SECURE_AUTH_SALT" "" }}';
$wodby['wp']['logged_in_key'] = '{{ getenv "WP_LOGGED_IN_KEY" "" }}';
$wodby['wp']['logged_in_salt'] = '{{ getenv "WP_LOGGED_IN_SALT" "" }}';
$wodby['wp']['nonce_key'] = '{{ getenv "WP_NONCE_KEY" "" }}';
$wodby['wp']['nonce_salt'] = '{{ getenv "WP_NONCE_SALT" "" }}';
$wodby['wp']['table_prefix'] = '{{ getenv "WP_TABLE_PREFIX" "wp_" }}';
$wodby['wp']['debug'] = '{{ getenv "WP_DEBUG" "" }}';

$wodby['redis']['host'] = '{{ getenv "REDIS_HOST" "" }}';
$wodby['redis']['port'] = '{{ getenv "REDIS_PORT" "6379" }}';
$wodby['redis']['password'] = '{{ getenv "REDIS_PASSWORD" "" }}';

if (isset($_SERVER['HTTP_X_REAL_IP'])) {
  $_SERVER['REMOTE_ADDR'] = $_SERVER['HTTP_X_REAL_IP'];
}

if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
  $_SERVER['HTTPS'] = 'on';
}

defined('WP_HOME')    || define('WP_HOME', $wodby['base_url']);
defined('WP_SITEURL') || define('WP_SITEURL', $wodby['base_url']);

defined('DB_HOST')     || define('DB_HOST', $wodby['db']['host']);
defined('DB_NAME')     || define('DB_NAME', $wodby['db']['name']);
defined('DB_USER')     || define('DB_USER', $wodby['db']['username']);
defined('DB_PASSWORD') || define('DB_PASSWORD', $wodby['db']['password']);
defined('DB_CHARSET')  || define('DB_CHARSET', $wodby['db']['charset']);
defined('DB_COLLATE')  || define('DB_COLLATE', $wodby['db']['collation']);

defined('AUTH_KEY')         || define('AUTH_KEY', $wodby['wp']['auth_key']);
defined('AUTH_SALT')        || define('AUTH_SALT',$wodby['wp']['auth_key']);
defined('SECURE_AUTH_KEY')  || define('SECURE_AUTH_KEY', $wodby['wp']['secure_auth_key']);
defined('SECURE_AUTH_SALT') || define('SECURE_AUTH_SALT', $wodby['wp']['secure_auth_salt']);
defined('LOGGED_IN_KEY')    || define('LOGGED_IN_KEY', $wodby['wp']['logged_in_key']);
defined('LOGGED_IN_SALT')   || define('LOGGED_IN_SALT', $wodby['wp']['logged_in_salt']);
defined('NONCE_KEY')        || define('NONCE_KEY', $wodby['wp']['nonce_key']);
defined('NONCE_SALT')       || define('NONCE_SALT', $wodby['wp']['nonce_salt']);
defined('FS_METHOD')        || define('FS_METHOD', 'direct');

if (!empty($wodby['redis']['host'])) {
  defined('WP_REDIS_HOST')     || define('WP_REDIS_HOST', $wodby['redis']['host']);
  defined('WP_REDIS_PORT')     || define('WP_REDIS_PORT', $wodby['redis']['port']);
  defined('WP_REDIS_PASSWORD') || define('WP_REDIS_PASSWORD', $wodby['redis']['password']);
}

isset($table_prefix) || $table_prefix  = $wodby['wp']['table_prefix'];
defined('WP_DEBUG')  || define('WP_DEBUG', (bool) $wodby['wp']['debug']);