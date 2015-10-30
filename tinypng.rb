#!/usr/bin/env ruby
#
# Quick'n'dirty script for PNG compression using the TinyPNG service
#
# by Jeff Ward (jcward.com, github.com/jcward)
#
# Notes:
# - requires sign-up, api key from: https://tinypng.com/developers
# - modifies files in place

require 'json'

$api_key = 'secret'
$min_size = 1024 # ignore files less than 1kb

if (ARGV.length==0) then
  puts "usage: tinypng.rb <dir or file> [more dirs or files]"
end

ARGV.each { |a|
  if a.match(/^\d+$/) then
    $min_size = a.to_i 
    puts "Min filesize set to #{$min_size}"
  end
}

$files = []
def push_file f
  if (!$files.include?(f) &&
      f.match(/png$/i) &&
      File.size(f) > $min_size) then
    $files.push(f)
  end
end
ARGV.each { |d_or_f|
  if (File.directory?(d_or_f)) then
    `find "#{d_or_f}" -type f`.split("\n").each { |f|
      push_file f
    }
  else
    push_file d_or_f
  end
}
$files.select! { |f| f.match(/png$/i) }

puts "Running tinypng on #{$files.length} files over #{$min_size} bytes..."
$files.each { |f|
  data = JSON.parse `curl -s --user api:#{ $api_key } --data-binary @#{f} https://api.tinypng.com/shrink`
  puts " - #{f} #{data['input']['size']} --> #{data['output']['size']} (#{data['output']['ratio']*100}%)"
  `cp #{f} /tmp/`
  `curl -s #{data['output']['url']} -o #{f}`
}
