/*
 * css-stats
 * https://github.com/apticknor/css-stats
 *
 * Copyright (c) 2013 Anthony Ticknor
 * Licensed under the MIT license.
 */

'use strict';

module.exports = function(grunt) {

  // Please see the Grunt documentation for more information regarding task
  // creation: http://gruntjs.com/creating-tasks

  grunt.registerMultiTask('css_stats', 'Analyze and refine your CSS!', function() {
    // Merge task-specific and/or target-specific options with these defaults.
    var options = this.options({
      path: "test/fixtures"
    });


    var done = this.async();

    grunt.util.spawn({
      // The command to execute. It should be in the system path.
      cmd: "bash",
      // If specified, the same grunt bin that is currently running will be
      // spawned as the child command, instead of the "cmd" option. Defaults
      // to false.
      // grunt: false,
      // An array of arguments to pass to the command.
      args: [ __dirname + "/css-stats-ack.sh"],
      // Additional options for the Node.js child_process spawn method.
      opts: {
        cwd: options.path
      }
      // If this value is set and an error occurs, it will be used as the value
      // and null will be passed as the error value.
      // fallback: fallbackValue
    }, function (err, result, code) {
      if (err) {
        throw err;
      }

      grunt.log.writeln(result.stdout);
      done();

    });

  });

};
