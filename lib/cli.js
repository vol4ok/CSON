/*!
 * CSON
 * Copyright(c) 2012 vol4ok <admin@vol4ok.net>
 * MIT Licensed
*/
/** Module dependencies
*/
var BANNER, CSON, OptionParser, SWITCHES, VERSION, basename, coffee, extname, fs, main, path;

require('colors');

fs = require('fs');

path = require('path');

coffee = require('coffee-script');

OptionParser = require('coffee-script/lib/coffee-script/optparse').OptionParser;

CSON = require('./CSON');

extname = path.extname, basename = path.basename;

VERSION = "0.1";

BANNER = 'Usage: cson [options] path/to/json/file';

SWITCHES = [['-o', '--output [FILE*]', 'output file'], ['-u', '--uglify', 'compact print'], ['-c', '--cson', 'convert JSON to CSON'], ['-s', '--stdout', 'print to stdout'], ['-v', '--version', 'show version'], ['-h', '--help', 'display this help message']];

/** Entry point
*/

main = function() {
  var cson, i, input, json, o, optParser, output, _len, _ref, _results;
  optParser = new OptionParser(SWITCHES, BANNER);
  o = optParser.parse(process.argv.slice(2));
  if (o.help) {
    console.log(optParser.help());
    return;
  }
  if (o.version) {
    console.log("CSON v" + VERSION + "\nCopyright(c) 2012 vol4ok <admin@vol4ok.net ");
    return;
  }
  if (o.arguments.length === 0) {
    console.log('Error: no input file!'.red);
    console.log(optParser.help());
    return;
  }
  _ref = o.arguments;
  _results = [];
  for (i = 0, _len = _ref.length; i < _len; i++) {
    input = _ref[i];
    cson = fs.readFileSync(input, 'utf-8');
    json = o.cson ? CSON.toCSON(cson) : CSON.toJSON(cson, o.uglify);
    if (o.stdout) console.log(json);
    output = o.output && o.output[i] ? o.output[i] : basename(input, extname(input)) + (o.cson ? '.cson' : '.json');
    _results.push(fs.writeFileSync(output, json, 'utf-8'));
  }
  return _results;
};

main();
