# grunt-makensis

> Grunt plugin for creating a windows installer with makensis

__Requires__: [Makensis](http://nsis.sourceforge.net/Main_Page) command-line tool to be installed

## Getting Started
This plugin requires Grunt `~0.4.5`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-makensis --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-makensis');
```

## The "makensis" task

### Overview
In your project's Gruntfile, add a section named `makensis` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  makensis: {
    options: {
      srcDir: 'directory/of/source/files',
      buildDir: 'directory/for/the/exe/to/go',
      appName: 'Name-of-my-app',
      setupName: '_installer'
    }
  },
});
```

### Options

#### options.srcDir
Type: `String`
Default value: There is no default value, this is required for input

A string value that is the directory to the files that you want wrapped up into the windows installer

#### options.buildDir
Type: `String`
Default value: `'/'`

A string value that is the directory for where the `.exe` file will go

#### options.appName
Type: `String`
Default value: `'Windows_app'`

A string value that is the name of the application

#### options.setupName
Type: `String`
Default value: `'_installer'`

A string value that is the name to add at the appName for the installer

### Usage Examples

```js
grunt.initConfig({
  makensis: {
    options: {
      srcDir: 'directory/of/source/files',
      buildDir: 'directory/for/the/exe/to/go',
      appName: 'Name-of-my-app',
      setupName: '_installer'
    }
  },
});
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

## Release History
* v0.4.0 - 7/24/15 - Build directory updates and setupName option added
* v0.3.0 - 5/11/15 - Proper Logging Release
* v0.1.0 - 4/15/15 - Initial Release

## Contributors
* [Richard Lucas](https://github.com/ralucas)
* [Vidril César](https://github.com/Yimiprod)


