#!/usr/bin/env ruby

require 'set'

# TODO - get rid of this and just work with positions
class Node
  attr_reader :position

  def initialize(position)
    @position = position
  end

  def path(came_from)
    p = came_from[position]
    p.nil? ? [position] : p.path(came_from) + [position]
  end
end

Grid = Data.define(:grid) do
  include Enumerable

  attr_reader :height, :width

  def initialize(obj)
    g = obj[:grid]
    @height = g.length
    @width = g.first&.length
    super(obj)
  end

  def value_at(position)
    grid.dig(*position)
  end

  def neighbours(node, parent, grandparent)
    ancestors = [node, parent, grandparent].compact

    result = ([[-1, 0], [0, -1], [0, 1], [1, 0]]
      .map{ |d| [d[0] + node.position[0], d[1] + node.position[1]] }
      .select{ |p| (0...height).include?(p[0]) && (0...width).include?(p[1]) }
      .select { |p|
        next true if ancestors.length != 3
        next false if ancestors.map{|a| a.position[0]}.push(p[0]).uniq.length == 1
        next false if ancestors.map{|a| a.position[1]}.push(p[1]).uniq.length == 1
        true
      }
      .map { |p| Node.new(p) })
    result
  end

  def coords
    grid.flat_map.with_index{|row, row_index| row.map.with_index{|cell, col_index| [row_index, col_index]}}
  end

  def a_star
    start = Node.new([0, 0])
    goal = Node.new([height - 1, width - 1])
    h = ->(node) {(node.position[0] - goal.position[0]).abs + (node.position[1] - goal.position[1]).abs} # Manhattan distance

    open_set = {start.position => start}
    closed_set = {}

    came_from = {}

    g_scores = Hash.new(Float::INFINITY)
    g_scores[start.position] = 0

    f_scores = Hash.new(Float::INFINITY)
    f_scores[start.position] = h.call(start)

    until open_set.empty?
      current_node = open_set.min_by{|pos, value| f_scores[pos]}[1]
      if current_node.position == goal.position
        return current_node.path(came_from) 
      end

      open_set.delete(current_node.position)
      closed_set[current_node.position] = current_node

      parent = came_from[current_node.position]
      grandparent = came_from[parent&.position]

      self.neighbours(current_node, parent, grandparent).each do |neighbour|
        if closed_set.include? neighbour.position
          next
        end

        tentative_g_score = g_scores[current_node.position] + value_at(neighbour.position)

        unless open_set.include? neighbour.position
          open_set[neighbour.position] = neighbour
        end

        if tentative_g_score < g_scores[neighbour.position]
          came_from[neighbour.position] = current_node
          g_scores[neighbour.position] = tentative_g_score
          f_scores[neighbour.position] = tentative_g_score + h.call(neighbour)
        end
      end
    end

    return nil
  end
end

if __FILE__ == $PROGRAM_NAME
  input = ARGF.readlines.map(&:strip).map{ _1.split("").map(&:to_i) }
  grid = Grid.new(input)

  position = [0, 0]
  optimal_path = grid.a_star
  empty_board = (0...grid.height).map { |r|
    (0...grid.width).map { |c|
      ' ' # grid.grid[r][c]
    }
  }
  optimal_path.each { |coord| empty_board[coord[0]][coord[1]] = "#" }

  puts empty_board.map{ _1.join("") }.join("\n")
  puts optimal_path.map{ grid.value_at(_1) }.sum
end