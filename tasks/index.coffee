gulp  = require("gulp")
fs    = require("fs")
tasks = fs.readdirSync("./tasks/")

tasks.forEach (task) ->
  is_task = 
    task.indexOf ".coffee" > -1 &&
    task.indexOf "index.coffee" == -1

  if is_task
    require "./#{task}"

gulp.task "default", [ "clean", "coffee" ]
