#!/usr/bin/env python

chapter_dir = 'chapters'
total_dir = 'total'

from os import listdir
from os.path import isfile, join

chapters = []

for file in listdir(chapter_dir):
  chapters.append(file)

chapters.sort()
chapter_list = []

for c in chapters:
  chapter_number = c[0] + c[1]
  if chapter_number not in chapter_list:
    chapter_list.append(chapter_number) 

for ch in chapter_list:
  chapter_file_name = total_dir + '/Chapter_' + ch
  ch_file = open(chapter_file_name, 'w')
  for chapter in chapters:
    if chapter.startswith(ch):
      tempfile_name = chapter_dir + '/' + chapter
      tempfile = open(tempfile_name, 'r')
      ch_file.write(tempfile.read())
      tempfile.close()
  ch_file.close()

