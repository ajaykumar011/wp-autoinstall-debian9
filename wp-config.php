<?php
/**
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */

#define( 'ALTERNATE_WP_CRON', true );
#define( 'DISABLE_WP_CRON', 'true');
#define( 'WP_CRON_LOCK_TIMEOUT', 900);
#define( 'AUTOSAVE_INTERVAL', 300);
#define( 'WP_MEMORY_LIMIT', '256M' );
#define( 'FS_CHMOD_DIR', ( 0755 & ~ umask() ) );
#define( 'FS_CHMOD_FILE', ( 0644 & ~ umask() ) );
#define( 'WP_ALLOW_REPAIR', true );
#define( 'CONCATENATE_SCRIPTS', false );

/* UPdate Wordpress Settings */
#define( 'AUTOMATIC_UPDATER_DISABLED', true );
#define( 'WP_AUTO_UPDATE_CORE', false );
#define( 'FORCE_SSL_LOGIN', true);
#define( 'FORCE_SSL_ADMIN', true);

/* Cache Settings */

#define('WP_CACHE', true);      // enable the cache
#define('ENABLE_CACHE', true);  // enable the cache
#define('CACHE_EXPIRATION_TIME', 3600); // in seconds

/* Database configuration starts here */
/** MySQL database Database ***/

define( 'DB_NAME', 'database_name_here' );

/** MySQL database username */
define( 'DB_USER', 'username_here' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password_here' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/* Aviod asking for ftp credentials for installation */

define( 'FS_METHOD', 'direct' ); 

/**#@+
 * Authentication Unique Keys and Salts.
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'put your unique phrase here' );
define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
define( 'NONCE_KEY',        'put your unique phrase here' );
define( 'AUTH_SALT',        'put your unique phrase here' );
define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
define( 'NONCE_SALT',       'put your unique phrase here' );

/* The value of WPSalts come from the script */

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wpr_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', true );
define( "WP_DEBUG_LOG", true ); 
#define( 'SCRIPT_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}
/** Sets up WordPress vars and included files. */

define( 'CONCATENATE_SCRIPTS', false ); 
require_once( ABSPATH . 'wp-settings.php' );
