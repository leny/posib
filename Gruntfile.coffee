"use strict"

module.exports = ( grunt ) ->

    require( "matchdep" ).filterDev( "grunt-*" ).forEach grunt.loadNpmTasks

    grunt.initConfig
        clean:
            client:
                src: [ "src/client/scripts/**/*.js" ]
        coffee:
            server:
                expand: yes
                cwd: "src/server/"
                src: [
                    "**/*.litcoffee"
                ]
                dest: "lib/server/"
                ext: ".js"
                options:
                    bare: yes
            client:
                expand: yes
                cwd: "src/client/scripts/"
                src: [
                    "**/*.litcoffee"
                ]
                dest: "src/client/scripts/"
                ext: ".js"
        jshint:
            options:
                reporter: require "jshint-stylish"
                boss: yes
                curly: yes
                eqeqeq: yes
                eqnull: yes
                immed: yes
                latedef: yes
                loopfunc: yes
                newcap: yes
                noarg: yes
                noempty: yes
                sub: yes
                undef: yes
                unused: yes
                white: no
                "-W030": yes
                "-W018": yes
                # specific addition to jshint for coffeescript issues - might be discussed
                shadow: yes
                "-W055": yes
                "-W040": yes
                "-W116": yes
            server:
                options:
                    node: yes
                src: [ "lib/server/**/*.js" ]
            client:
                options:
                    browser: yes
                    jquery: yes
                    devel: yes
                    globals:
                        require: yes
                src: [ "src/client/scripts/**/*.js" ]
        browserify:
            connect:
                files:
                    "lib/client/js/connect.js": [ "src/client/scripts/modules/connect/connect.js" ]
        uglify:
            connect:
                files:
                    "lib/client/js/connect.min.js": [ "lib/client/js/connect.js" ]
        sass:
            options:
                style: "compressed"
            public:
                files:
                    "lib/client/styles/public.css": "src/client/styles/public.sass"
            admin:
                files:
                    "lib/client/styles/admin.css": "src/client/styles/admin.sass"
        csso:
            options:
                report: "gzip"
            public:
                files:
                    "lib/client/styles/public.min.css": "lib/client/styles/public.css"
            admin:
                files:
                    "lib/client/styles/admin.min.css": "lib/client/styles/admin.css"
        bumpup: "package.json"
        watch:
            server:
                files: [
                    "src/server/**/*.litcoffee"
                ]
                options:
                    nospawn: yes
                tasks: [
                    "clear"
                    "newer:coffee:server"
                    "bumpup:prerelease"
                ]
            client:
                files: [
                    "src/client/**/*.litcoffee"
                ]
                options:
                    nospawn: yes
                tasks: [
                    "clear"
                    "coffee:client"
                    "browserify"
                    "clean:client"
                    "bumpup:prerelease"
                ]
            styles:
                files: [
                    "src/client/styles/**/*.sass"
                ]
                options:
                    nospawn: yes
                tasks: [
                    "clear"
                    "sass"
                    "bumpup:prerelease"
                ]
        nodemon:
            work:
                script: "sample/posib.js"
                options:
                    ext: "js"
                    watch: [ "lib/server" ]
                    ignore: [
                        "node_modules/**"
                        "src/**"
                        "sample/**"
                    ]
        concurrent:
            work:
                tasks: [ "nodemon:work", "watch" ]
                options:
                    logConcurrentOutput: yes
        todo:
            all:
                src: [
                    "src/**/*"
                ]

    grunt.registerTask "default", [
        "clear"
        "coffee"
        "jshint"
        "browserify"
        "uglify"
        "clean"
        "sass"
        "bumpup:prerelease"
    ]

    grunt.registerTask "work", [
        "clear"
        "coffee"
        "jshint"
        "browserify"
        "clean"
        "sass"
        "bumpup:prerelease"
        "concurrent:work"
    ]
