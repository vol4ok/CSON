###!
 * CSON
 * Copyright(c) 2012 vol4ok <admin@vol4ok.net>
 * MIT Licensed
###

###* Module dependencies ###

coffee = require 'coffee-script'
vm     = require 'vm'
_      = require 'underscore'

step = '  '

exports.parse = parse  = (cson) -> return vm.runInThisContext(coffee.compile(cson, {bare: yes}))
exports.stringify = stringify = (obj, prefix = '') -> 
  cson = ""
  switch typeof obj
    when "object"
      if _.isArray(obj)  
        if _.isEmpty(obj)
          cson += "[]" 
        else
          cson += "["
          for val,i in obj
            cson += ", " unless i == 0
            cson += stringify(val, prefix)
          cson += "]"
      else 
        if _.isEmpty(obj)
          cson += "{}" 
        else
          cson += "\n"
          for key, val of obj
            key = "\"#{key}\"" unless /^[a-z$][a-z0-9_$]*$/i.test(key)
            cson += "#{prefix}#{key}: "
            cson += stringify(val, prefix + step) + '\n'
    when "string", "number"
      cson += JSON.stringify(obj)
    when "null"
      cson += "null"
    when "boolean"
      cson += if obj then "yes" else "no"
    else
      throw "Error: unknown type"
  return cson
exports.toJSON = toJSON = (cson, uglify = no) -> JSON.stringify(parse(cson), null, if uglify then null else '  ')
exports.toCSON = toCSON = (json) -> stringify(JSON.parse(json))