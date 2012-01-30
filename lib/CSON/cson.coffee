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

# a = '''
# test: 
#   node_1: [1,2,3]
#   node_2: "string-value"
#   node_3: 'string'
#   node_4: [1,"2", yes, on]
#   node_5: off
#   node_6: 
#     sub_node_2: 1234
# '''
# 
# console.log parse(a)