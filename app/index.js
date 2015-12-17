var yeoman = require('yeoman-generator');

var FramerGenerator = yeoman.generators.Base.extend({
  constructor: function() {
    yeoman.generators.Base.apply(this, arguments);
  },
  writing: {
    packagsjson: function() {
      var pkg = {
        'version': '0.1.0',
        'dependencies': {},
        'scripts': {
          'start': 'gulp',
          'build': 'gulp build',
          'postinstall': 'cd ./node_modules/framerjs && make build'
        }
      };
      this.write('package.json', JSON.stringify(pkg));
    },
    gulpfile: function() {
      this.log.writeln('Copying gulpfile');
      this.fs.copy(
        this.templatePath('gulpfile.coffee'),
        this.destinationPath('gulpfile.coffee')
      )},
    otherFiles: function() {
      this.log.writeln('Copying project files');
      this.fs.copy(
        this.templatePath('src/**/*.*'),
        this.destinationPath('src')
      )}
  },
  install: function() {
    var done = this.async();
    this.log.writeln('npm installing');
    this.spawnCommand('npm', [
      'install',
      'coffee-script',
      'gulp',
      'gulp-coffee',
      'gulp-sketch',
      'gulp-util',
      'browser-sync',
      'browserify',
      'chalk',
      'coffee-reactify',
      'gulp-size',
      'gulp-sourcemaps',
      'pretty-hrtime',
      'vinyl-buffer',
      'vinyl-source-stream',
      'watchify',
      'gulp-uglify',
      '--save-dev',
      '--production'
    ])
    .on('exit', function() {
        done();
    }.bind(this));
  },
  end: function() {
    this.log.writeln('All set, run `npm start` to start dev server');
  }
});

module.exports = FramerGenerator;