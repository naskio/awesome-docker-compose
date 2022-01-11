module.exports = [
    'strapi::errors',
    {
        "name": "strapi::security",
        "config": {
            // 'contentSecurityPolicy': `<meta http-equiv="Content-Security-Policy" content="connect-src 'self' http://localhost:*">`,
            'contentSecurityPolicy': true,
        }
    },
    'strapi::cors',
    'strapi::poweredBy',
    'strapi::logger',
    'strapi::query',
    'strapi::body',
    'strapi::favicon',
    'strapi::public',
];
