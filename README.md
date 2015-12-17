# generator-framer-coffee

I use this tool to instead of [Framer Studio](http://framerjs.com/download) because I am looking for something as automated and low-friction as possible.

## Getting Started

Not every new computer comes with a Yeoman pre-installed. You only have to install it once.

```bash
$ npm install -g yo
```

### Yeoman Generators

To install generator-framer-coffee from npm, run:

```bash
$ npm install -g generator-framer-coffee
```

And then, create a directory to put you framer project in:

```bash
$ mkdir your-framer-proj && cd $_
```

After that, initiate the generator:

```bash
$ yo framer-coffee
```

This step takes time to install all dependencies that your project needs.

The [framer.js and sourcemap](http://builds.framerjs.com/920106e/Framer.zip) in this package have been pre-downloaded and put them into generator's templates.

Finally, run `npm start` to start your development server and see the demo project.

I'm using [browserify](https://github.com/substack/node-browserify) for code bundling and [browser-sync](https://www.browsersync.io) for the development web server.