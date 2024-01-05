<?php

use Runtime\Swoole\Runtime;


if(($_ENV['APP_RUNTIME'] ?? '') == Runtime::class) {
    $_SERVER['APP_RUNTIME_OPTIONS'] = [
        'host'     => '0.0.0.0',
        'port'     => in_array('openswoole', get_loaded_extensions()) ? 9801 : 9802,
        'mode'     => 2, //SWOOLE_PROCESS
        'settings' => [
            'enable_coroutine' => false,
            'daemonize' => false,
            'log_file' => dirname(__DIR__).'/var/log/swoole_http.log',
            'log_level' => 5, //SWOOLE_LOG_ERROR
            'max_request' => 500,
            'package_max_length' => 10 * 1024 * 1024,
            'reactor_num' => 16,
            'send_yield' => true,
            'socket_buffer_size' => 10 * 1024 * 1024,
//            'task_max_request' => 500,
//            'task_worker_num' => 4,
            'worker_num' => 16,
        ],
    ];
}