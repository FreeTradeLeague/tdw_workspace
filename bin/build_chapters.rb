#!/usr/bin/env ruby

require 'fileutils'
require 'optparse'

chapter_dir = 'chapters'
total_dir   = 'total'
book_dir    = 'book'

options = Hash.new(0)
option_parser = OptionParser.new do |opts|
  opts.on('-t', '--title TITLE', 'Title of the book') do |t|
    options[:title] = t
  end
end
option_parser.parse!

if options[:title] == 0
  book_name = 'Book'
else
  book_name = options[:title]
end
puts("book name is #{book_name}.")

if File.directory?(total_dir)
  FileUtils.rm_rf(total_dir)
end
Dir.mkdir(total_dir)

if File.directory?(book_dir)
  FileUtils.rm_rf(book_dir)
end
Dir.mkdir(book_dir)

if File.directory?(chapter_dir)
  chapter_files = Dir.entries(chapter_dir)
  chapter_files.sort!
else
  puts("Need chapters.")
  exit
end

def write_chapter(file, chapter)
end

chapter_space = "\n\n\n\n\n"

chapter_files.each do |chapter_file|
  if chapter_file.end_with?('.txt')
    chapter = File.read("#{chapter_dir}/#{chapter_file}")
    chapter_count = chapter_file[0..1]
    File.open("#{total_dir}/Chapter_#{chapter_count}", "a") do |file|
      file.write(chapter)
      file.write(chapter_space)
    end
    File.open("#{book_dir}/#{book_name}", "a+") do |file|
      file.write(chapter)
      file.write(chapter_space)
    end
  end
end
