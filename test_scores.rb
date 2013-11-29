require 'pry'
require 'csv'

class TestScores
  def initialize(file, students = [])
    @file = file
    @students = students
  end

  def parse_scores
    CSV.foreach(@file, :headers=>true) do |student|
      @students << student
    end
  end

  def count_scores
    @over_90_arr = []
    @over_80_arr = []
    @over_70_arr = []
    @below_70_arr = []
    @students.each do |student|
      @over_90_arr << student if student["Grade"].to_i >= 90
      @over_80_arr << student if student["Grade"].to_i >= 80 && student["Grade"].to_i < 90
      @over_70_arr << student if student["Grade"].to_i >= 70 && student["Grade"].to_i < 80
      @below_70_arr << student if student["Grade"].to_i < 70
    end
  end

  def output_scores
    puts ">= 90: #{@over_90_arr.count}"
    puts ">= 80: #{@over_80_arr.count}"
    puts ">= 70: #{@over_70_arr.count}"
    puts " < 70: #{@below_70_arr.count}"
    puts "\n=== >= 90 ==="
    @over_90_arr.each do |student|
      puts student["Name"]
    end
    puts "\n=== >= 80 ==="
    @over_80_arr.each do |student|
      puts student["Name"]
    end
    puts "\n=== >= 70 ==="
    @over_70_arr.each do |student|
      puts student["Name"]
    end
    puts "\n=== < 70 ==="
    @below_70_arr.each do |student|
      puts student["Name"]
    end
  end

end

file = "scores.csv"
scores = TestScores.new(file)
scores.parse_scores
scores.count_scores
scores.output_scores
