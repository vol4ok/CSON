###!
 * CSON
 * Copyright(c) 2012 vol4ok <admin@vol4ok.net>
 * MIT Licensed
###

###* Module dependencies ###

coffee = require 'coffee-script'
vm     = require 'vm'
# util   = require 'util'

exports.parse  = parse  = (cson) -> return vm.runInThisContext(coffee.compile(cson, {bare: yes}))
exports.toJSON = toJSON = (cson, uglify = no) -> JSON.stringify(parse(cson), null, if uglify then null else '  ')