require_relative "item"
require "byebug"
class List
    attr_accessor :label
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title,deadline,description=nil)
        return false if !Item.valid_date?(deadline)
        if description == nil 
            new_i = Item.new(title,deadline,"")
        else
            new_i = Item.new(title,deadline,description)
        end
        @items << new_i
        true
    end

    def size
        @items.length
    end

    def valid_index?(index)
        (0...@items.length).include?(index) || (1..size).map{|el| -el}.include?(index)
    end

    def swap(index_1,index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1],@items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        self[0]
    end

    def print
        puts "---------------------------------------------------------"    #57
        puts "#{self.label.upcase}".center(57)
        puts "---------------------------------------------------------"
        puts "Index | Item                    | Deadline      | Done   "
        puts "---------------------------------------------------------"
        (0...@items.length).each do |i|
            puts "#{i}".ljust(6) + "| " + "#{self[i].title}".ljust(24) + "| " + "#{self[i].deadline}".ljust(14) + "| " + "#{self[i].done}".ljust(7)
        end
        puts "---------------------------------------------------------"
    end

    def print_full_item(index) #32 10
        return false if !valid_index?(index)
        puts "-"*57
        puts "#{self[index].title}".ljust(32) + "#{self[index].deadline}".ljust(15) + "#{self[index].done}".ljust(15)
        puts "#{self[index].description}".ljust(57)
        puts "-"*57
    end

    def print_priority
        print_full_item(0)
    end

    def up(index,amount = 1)
        return false if !valid_index?(index)
        item = self[index]
        count = 0
        (1..size).each do |i|
            if self[-i] == item && count < amount
                swap(-i,-(i+1))
                count += 1
            end
        end
        true
    end

    def down(index,amount = 1)
        item = self[index]
        return false if !valid_index?(index)
        count = 0
        (0...size).each do |i|
            if self[i] == item && count < amount
                swap(i,i+1)
                count += 1
            end
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline}
    end

    def toggle(index)
        return false if !valid_index?(index)
        self[index].toggle
    end

    def remove_item(index)
        return false if !valid_index?(index)
        @items.delete_at(index)
        true
    end

    def purge
        @items.select {|item| !item.done}
    end
end