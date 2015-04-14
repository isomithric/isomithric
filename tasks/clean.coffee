gulp = require "gulp"
run  = require "gulp-run"

gulp.task "clean", (cb) ->
  run "rm -rf ./lib"
  .exec cb
