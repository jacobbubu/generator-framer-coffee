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

Finally, initiate the generator:

```bash
$ yo framer-coffee
```

This step takes time to install all dependencies that your project needs. One of the dependency is [framer.js](https://github.com/koenbok/Framer). `yo framer-coffee` will install it from npm and try to build it on the fly (The build step shoud be omitted if [framer.js](https://github.com/koenbok/Framer) could build it before publishing to npm, see issue https://github.com/koenbok/Framer/issues/71).

Run `yo framer-coffee` in China may be hung by downloading the file of https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-macosx.zip. This is because the Amazon S3 has been blocked by [GFW](https://en.wikipedia.org/wiki/Internet_censorship_in_China).