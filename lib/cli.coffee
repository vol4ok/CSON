###!
 * CSON
 * Copyright(c) 2012 vol4ok <admin@vol4ok.net>
 * MIT Licensed
###

###* Module dependencies ###

require 'colors'
fs           = require 'fs'
path         = require 'path'
coffee       = require 'coffee-script'
OptionParser = require('coffee-script/lib/coffee-script/optparse').OptionParser
CSON         = require('./CSON')

{extname, basename} = path

VERSION = "0.1"
BANNER = 'Usage: cson [options] path/to/json/file'
SWITCHES = [
  ['-o', '--output [FILE*]', 'output file']
  ['-u', '--uglify',         'compact print']
  ['-s', '--stdout',         'print to stdout']
  ['-v', '--version',        'show version']
  ['-h', '--help',           'display this help message']
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
    
  if o.arguments.length is 0
    console.log 'Error: no input file!'.red
    console.log optParser.help() 
    return
    
  for input,i in o.arguments      
    cson = fs.readFileSync(input, 'utf-8')
    json = CSON.toJSON(cson, o.uglify)
  
    console.log json if o.stdout
    
    output = if o.output and o.output[i]
    then o.output[i]
    else basename(input, extname(input)) + '.json'
    fs.writeFileSync(output, json, 'utf-8')    

main()
