#!/usr/bin/env ruby
input = ARGF.read.split(",")

Step = Data.define(:string) do
  attr_reader :label, :operator, :focal_length

  def initialize(obj)
    m = obj[:string].match /([a-z]+)([=-])(\d*)/
    @label, @operator = m.values_at(1,2)
    @focal_length = m[3].empty? ? nil : m[3].to_i
    super(obj)
  end

  def label_hash
    label.split("").reduce(0){|acc, char| ((acc + char.ord) * 17) % 256 }
  end

  def full_hash
    string.split("").reduce(0){|acc, char| ((acc + char.ord) * 17) % 256 }
  end

  def inspect
    string
  end
end

steps = input.map{|string| Step.new(string)}
puts "Part 1: #{steps.map(&:full_hash).sum}"

boxes = Array.new(256).map{[]}
steps.each do |step|
  box = boxes[step.label_hash]
  i = box.index{|entry| entry.label == step.label}
  case step.operator
  when "="
    if i.nil?
      box.append(step)
    else
      box[i] = step
    end
  when "-"
    box.delete_at(i) unless i.nil?
  end
end

focusing_power = boxes.flat_map.with_index { |box, i| box.map.with_index { |step, j| (i + 1) * (j + 1) * step.focal_length } }.sum
puts "Part 2: #{focusing_power}"