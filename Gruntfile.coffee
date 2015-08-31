#global module:false

"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"
  grunt.loadNpmTasks "grunt-postcss"

  grunt.initConfig

    copy:
      jquery:
        files: [{
          expand: true
          cwd: "bower_components/jquery/dist/"
          src: "jquery.min.js"
          dest: "vendor/js/"
        }]
      bootstrap:
        files: [{
          expand: true
          cwd: "bower_components/bootstrap-sass/assets/javascripts/"
          src: "bootstrap.min.js"
          dest: "vendor/js/"
        }]
      glyphicons: 
        files: [{
          expand: true
          cwd: "bower_components/bootstrap-sass/assets/fonts/bootstrap"  
          src: "*"
          dest: "fonts/"
        }]
      respond:
        files: [{
          expand: true
          cwd: "bower_components/respond/dest/"
          src: "respond.min.js"
          dest: "vendor/js/"
        }]
      html5shiv:
        files: [{
          expand: true
          cwd: "bower_components/html5shiv/dist/"
          src: "html5shiv.min.js"
          dest: "vendor/js/"
        }]
      gmaps:
        files: [{
          expand: true
          cwd: "bower_components/gmaps/"  
          src: "gmaps.min.js"
          dest: "vendor/js/"
        }]

    exec:
      jekyll:
        cmd: "jekyll build --trace"

    postcss:
      options: 
        processors: [require("autoprefixer-core")({browsers: "last 2 versions"})]
      dist:
        src: "_site/css/*.css"

    watch:
      options:
        livereload: true
      source:
        files: [
          "_drafts/**/*"
          "_includes/**/*"
          "_layouts/**/*"
          "_posts/**/*"
          "css/**/*"
          "bower_components/**/*"
          "_config.yml"
          "*.html"
          "*.textile"
        ]
        tasks: [
          "exec:jekyll"
        ]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

  grunt.registerTask "build", [
    "copy"
    "exec:jekyll"
    "postcss:dist"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]
