###!
 * CSON
 * Copyright(c) 2012 vol4ok <admin@vol4ok.net>
 * MIT Licensed
###

###* Module dependencies ###

require 'colors'
fs           = require 'fs'
coffee       = require 'coffee-script'
OptionParser = require('coffee-script/lib/coffee-script/optparse').OptionParser
CSON         = require('./cson')

VERSION = "0.1"
BANNER = 'Usage: cson [options]'
SWITCHES = [
  ['-i', '--input [FILE]',  'input file']
  ['-o', '--output [FILE]', 'output file']
  ['-u', '--uglify',        'compact print']
  ['-v', '--version',       'show version']
  ['-h', '--help',          'display this help message']
]

###* Entry point ###

main = () ->
  optParser  = new OptionParser SWITCHES, BANNER
  o = optParser.parse process.argv[2..]
  
  if o.help
    console.log optParser.help() 
    return
    
  if o.version
    console.log "CSON v#{VERSION}\nCopyright(c) 2012 vol4ok <admin@vol4ok.net "
    return
    
  unless o.input
    console.log 'Error: no input file!'.red
    console.log optParser.help() 
    return
      
  cson = fs.readFileSync(o.input, 'utf-8')
  json = CSON.toJSON(cson, o.uglify)
  
  if o.output
    fs.writeFileSync(o.output, json, 'utf-8')
  else
    console.log json

main()
