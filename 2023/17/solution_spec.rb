#!/usr/bin/env ruby

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "rspec"
end

require "rspec/autorun"
require_relative "./solution"

RSpec.describe Grid, "#a_star" do
  it "finds the shortest path 1" do
    g = described_class.new([
      [1, 2],
      [3, 4]
    ])
    expect(g.a_star).to eq [[0, 0], [0, 1], [1, 1]]
  end

  it "finds the shortest path 2" do
    g = described_class.new([
      [1, 1, 1, 1],
      [9, 9, 9, 1],
      [9, 9, 9, 1],
      [9, 9, 9, 1],
    ])
    expect(g.a_star).to eq [[0, 0], [0, 1], [0, 2], [1, 2], [1, 3], [2, 3], [3, 3]]
  end

  it "finds the shortest path 3" do
    g = described_class.new([
      [1, 9, 9, 9],
      [1, 9, 9, 9],
      [1, 9, 9, 9],
      [1, 1, 1, 1],
    ])
    expect(g.a_star).to eq [[0, 0], [1, 0], [2, 0], [2, 1], [3, 1], [3, 2], [3, 3]]
  end

  it "finds the shortest path 4" do
    g = described_class.new([
      [2, 4, 1],
      [3, 3, 1],
    ])
    expect(g.a_star).to eq [[0, 0], [0, 1], [0, 2], [1, 2]]
  end

  it "should match the sample", focus: true do
    g = described_class.new([
      [2,4,1,3,4,3,2,3,1,1,3,2,3],
      [3,2,1,5,4,5,3,5,3,5,6,2,3],
      [3,2,5,5,2,4,5,6,5,4,2,5,4],
      [3,4,4,6,5,8,5,8,4,5,4,5,2],
      [4,5,4,6,6,5,7,8,6,7,5,3,6],
      [1,4,3,8,5,9,8,7,9,8,4,5,4],
      [4,4,5,7,8,7,6,9,8,7,7,6,6],
      [3,6,3,7,8,7,7,9,7,9,6,5,3],
      [4,6,5,4,9,6,7,9,8,6,8,8,7],
      [4,5,6,4,6,7,9,9,8,6,4,5,3],
      [1,2,2,4,6,8,6,8,6,5,5,6,3],
      [2,5,4,6,5,4,8,8,8,7,7,3,5],
      [4,3,2,2,6,7,4,6,5,5,5,3,3],
    ])
    expect(g.a_star.map{ g.value_at(_1)}.sum).to eq 102
  end
end