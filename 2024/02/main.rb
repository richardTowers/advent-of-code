#!/usr/bin/env ruby
# frozen_string_literal: true

lines = ARGF.readlines
reports = lines.map { |line| line.split.map(&:to_i) }

def is_report_safe(report)
  pp report
  safe = true
  prev = report[0]
  original_direction = (report[1] <=> report[0])
  report.drop(1).each do |level|
    difference = (level - prev).abs
    direction = (level <=> prev)

    safe = false if difference < 1 || difference > 3 || direction != original_direction
    prev = level
  end
  pp safe
  safe
end

safe_reports = reports.select do |report|
  candidate_reports = (0..report.length).map do
    new_report = report.dup
    new_report.delete_at(_1)
    new_report
  end
  [report, *candidate_reports].any? { is_report_safe(_1) }
end

pp safe_reports.count
