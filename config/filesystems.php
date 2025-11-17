<?php

return [

    'default' => env('FILESYSTEM_DISK', 'media'),

    'disks' => [
        'public' => [
            'driver' => 'local',
            'root' => storage_path('app/public'),
            'url' => env('APP_URL').'/storage-files',
            'visibility' => 'public',
            'throw' => false,
        ],

        'media' => [
            'driver' => 'local',
            'root'   => storage_path('app/public/media'),
            'url'    => env('APP_URL').'/storage-files/media',
            'visibility' => 'public',
            'throw' => false,
        ],
    ],

    'links' => [
        public_path('storage') => storage_path('app/public'),
    ],

];
