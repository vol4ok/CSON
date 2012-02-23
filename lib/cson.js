/*!
 * CSON
 * Copyright(c) 2012 vol4ok <admin@vol4ok.net>
 * MIT Licensed
*/
/** Module dependencies
*/
var coffee, parse, step, stringify, toCSON, toJSON, vm, _;

coffee = require('coffee-script');

vm = require('vm');

_ = require('underscore');

step = '  ';

exports.parse = parse = function(cson) {
  return vm.runInThisContext(coffee.compile(cson, {
    bare: true
  }));
};

exports.stringify = stringify = function(obj, prefix) {
  var cson, i, key, val, _len;
  if (prefix == null) prefix = '';
  cson = "";
  switch (typeof obj) {
    case "object":
      if (_.isArray(obj)) {
        if (_.isEmpty(obj)) {
          cson += "[]";
        } else {
          cson += "[";
          for (i = 0, _len = obj.length; i < _len; i++) {
            val = obj[i];
            if (i !== 0) cson += ", ";
            cson += stringify(val, prefix);
          }
          cson += "]";
        }
      } else {
        if (_.isEmpty(obj)) {
          cson += "{}";
        } else {
          cson += "\n";
          for (key in obj) {
            val = obj[key];
            if (!/^[a-z$][a-z0-9_$]*$/i.test(key)) key = "\"" + key + "\"";
            cson += "" + prefix + key + ": ";
            cson += stringify(val, prefix + step) + '\n';
          }
        }
      }
      break;
    case "string":
    case "number":
      cson += JSON.stringify(obj);
      break;
    case "null":
      cson += "null";
      break;
    case "boolean":
      cson += obj ? "yes" : "no";
      break;
    default:
      throw "Error: unknown type";
  }
  return cson;
};

exports.toJSON = toJSON = function(cson, uglify) {
  if (uglify == null) uglify = false;
  return JSON.stringify(parse(cson), null, uglify ? null : '  ');
};

exports.toCSON = toCSON = function(json) {
  return stringify(JSON.parse(json));
};
