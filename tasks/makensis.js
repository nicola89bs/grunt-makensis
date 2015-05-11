/*
 * grunt-makensis
 * https://github.com/ralucas/grunt-makensis
 *
 * Copyright (c) 2015 ralucas
 * Licensed under the MIT license.
 */

'use strict';

var path = require('path');
var Q = require('q');
var _ = require('lodash');

module.exports = function(grunt) {

  grunt.registerTask('makensis', 'Grunt plugin for creating a windows installer with makensis', function() {

    var done = this.async();

    var options = this.options({
      buildDir: '/',
      appName: 'Windows_App'
    });

    if (!options.srcDir) {
      throw new Error('srcDir is required');
    }

    if ( !(/\/$/.test(options.srcDir)) ) {
      options.srcDir = options.srcDir + '/';
    }

    var dataObj = _.extend(options, {files: []});

    // recurse the directory
    grunt.file.recurse(options.srcDir, function(abspath, rootdir, subdir, filename) {
      // just take the files not in locales
      if (!subdir) {
        dataObj.files.push(filename);
        
        if (/\.exe/.test(filename)) {
          dataObj.exeFile = filename;
        }
      }
    });

    var nsiTemplate = grunt.file.read(path.join(__dirname, '..', '/templates/template.nsi'));

    var nsiTemplateString = grunt.template.process(nsiTemplate, {data: dataObj});

    grunt.file.write('./created_template.nsi', nsiTemplateString);

    var createdNsiTemplateFile = './created_template.nsi';

    Q.when(createdNsiTemplateFile, function() {
      grunt.util.spawn({
        cmd: 'makensis',
        args: [createdNsiTemplateFile],
        opts: {stdio: 'inherit'}
      }, function(error, result, code) {
        if (error) {
          throw new Error(error);
        }  
        console.log('code: ', code);
        done();
      });
    });
  });
   
};

