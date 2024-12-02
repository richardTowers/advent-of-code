#!/usr/bin/env ruby
# frozen_string_literal: true

lines = ARGF.readlines
reports = lines.map { |line| line.split.map(&:to_i) }

def report_safe?(report)
  directions = report.each_cons(2).map { |l, r| l <=> r }
  differences = report.each_cons(2).map { |l, r| (l - r).abs }
  directions.all? { |d| d == directions.first } && differences.all? { |d| (1..3).include? d }
end

part1 = reports.count { report_safe?(_1) }

part2 = reports.count do |report|
  candidate_reports = (0..report.length).map { |index_to_drop| report.reject.with_index { index_to_drop == _2 } }
  [report, *candidate_reports].any? { report_safe?(_1) }
end

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
