source = "75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"

s = source.split(/\n/)

(0..s.length-1).each do |r|
  s[r] = s[r].split(/\s/)
end

class Node

  def initialize(n)
    @content = n
    @children = []
  end

  def <<(n)
    @children << n
  end

  def content
    @content
  end

  def children
    @children
  end

  def print
    return if children == []
    puts "node"
    puts content
    puts "children:"
    children.each {|n| puts n.content} 
    children.each {|n| n.print} 
  end

end

node_list = []



root = Node.new(s[0][0])
node_list = []
next_node_list = []
next_node_list << root
(1..s.length-1).each do |i|
  node_list = Array.new(next_node_list)
  next_node_list = []
  (0..s[i].length-1).each do |j|
    n = Node.new(s[i][j])
    node_list[0] << n
    puts "***********"
    puts "#{node_list[0].content} -> #{n.content}"
    if j > 0 && node_list.length > 1
      node_list[1] << n
      puts "#{node_list[1].content} -> #{n.content}"
    end
    next_node_list << n
    node_list.shift if j >= 1
    puts "node_list"
    node_list.each {|nl| puts nl.content}
    puts "next_node_list"
    next_node_list.each {|nl| puts nl.content}
    
  end
end

root.print

$max_sum = 0
puts s.to_s
def traverse_sum(n, cur_sum, path)
  next_sum = cur_sum + n.content.to_i
  #$max_sum = next_sum if next_sum > $max_sum && n.children == []
  
  if n.children == []
    $max_sum = next_sum if next_sum > $max_sum
    puts "path " + path.to_s + next_sum.to_s
  end
  n.children.each { |c| traverse_sum(c, next_sum, Array.new(path) << c.content)}
end

traverse_sum(root, 0, [root.content])
puts $max_sum