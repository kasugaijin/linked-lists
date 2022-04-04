# class contained linked list and methods
class LinkedList
  attr_accessor :head, :tail, :count

  def initialize
    @head = nil
    @tail = nil
    @count = 0
  end

  # Makes a new head. If a head node exists it prepends the new node.
  # Else it makes a stand alone head node pointing to nil.
  def new_head(value)
    node = Node.new(value)
    if @head.nil?
      node.next_node = nil
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
    @count += 1
  end

  # If nodes exist, make a new node and set next to nil and the old tail's next to the new tail
  def append(value)
    if @head.nil?
      puts 'you cannot append to an empty list. Run new_head() first.'
    else
      old_tail = @tail
      node = Node.new(value)
      node.next_node = nil
      old_tail.next_node = node
      @tail = node
      @count += 1
    end
  end

  def size
    puts "There are #{@count} nodes in this linked list."
  end

  def head_node
    puts "The head value is #{@head.value}."
    puts "The head object ID is #{@head.object_id}."
  end

  def tail_node
    puts "The tail value is #{@tail.value}."
    puts "The tail object ID is #{@tail.object_id}."
  end

  # Head node has index of 0. Until loop sets new value of current to next node each iteration.
  def get_node(index)
    if index > @count - 1
      puts "Invalid entry. Enter an index 0 through #{@count - 1}."
    else
      i = 0
      current = @head
      until i == index do
        current = current.next_node
        i += 1
      end
      current
    end
  end

  # find the penultimate node and change its next_node to nil to remove the current last node
  def pop
    new_tail = get_node(@count - 2)
    new_tail.next_node = nil
    @count -= 1
    @tail = new_tail
  end

  # return true if the searched for value exists in the node list
  def contain(value)
    current = @head
    return true if current.value == value

    until current.next_node.nil?
      current = current.next_node
      return true if current.value == value
    end
    false
  end

  # return the index of a node that contains the inputted value, or nil if not found
  def find(value)
    current = @head
    return 0 if current.value == value

    index = 1
    until current.next_node.nil?
      current = current.next_node
      return index if current.value == value

      index += 1
    end
    puts "#{value} is not in this linked list."
  end

  # add all node values to an array in parentheses, then join array with arrow
  def string
    collection = []
    collection << "(#{@head.value})"

    current = @head
    until current.next_node.nil?
      current = current.next_node
      collection << "(#{current.value})"
    end
    collection.join(' -> ')
  end

  # validate the insert index to prevent an error or recommend a more suitable method.
  # if arguments pass validation, pass them onto insert method
  def insert(value, index)
    if @count <= 2 
      puts 'Use new_head() or append instead().'
    else
      insert_node(value, index)
    end
  end

  # Puts new node at index and points previous node to new node, and new node 
  def insert_node(value, index)
    new_node = Node.new(value)
    preceding_node = get_node(index - 1)
    successive_node = get_node(index)

    preceding_node.next_node = new_node
    new_node.next_node = successive_node
    @count += 1
  end

  # account for edge cases where the index is the first or last node
  # otherwise get the preceding node (index-1) and sets its next_node to the successive node (index+1)
  def remove(index)
    if index == 0
      new_head = @head.next_node
      @head.next_node = nil
      @head = new_head
    elsif index == @count - 1
      return puts 'Use pop() instead.'
    else
      preceding_node = get_node(index - 1)
      successive_node = get_node(index + 1)
      preceding_node.next_node = successive_node
    end
    @count -= 1
  end
end

# creates new nodes that contain a value and link to another node
class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end

end

list = LinkedList.new
list.new_head('first')
list.append('second')
list.append('third')
list.append('fourth')
list.append('fifth')
list.append('sixth')
list.append('seventh')

list.head_node
list.tail_node
list.size

puts list.get_node(5).value

list.pop
puts list.size
puts list.tail_node

puts list.contain('third')
puts list.contain('wibblybottom')
puts list.find('first')
puts list.find('wibblybottom')
puts list.string

list.insert('intruder', 5)
puts list.string
list.size

list.remove(3)
puts list.string
list.size

list.new_head('zeroth')
puts list.string
list.size