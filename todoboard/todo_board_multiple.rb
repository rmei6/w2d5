require_relative "item"
require_relative "list"

class TodoBoard
    def initialize
        @board = Hash.new(0)
    end

    def get_command
        print "Enter a command: "
        cmd,label, *args = gets.chomp.split(" ")
        case cmd
        when "mklist"
            if @board.key?(label)
                puts "That label already exists"
            else
                @board[label] = List.new(label)
            end
        when "ls"
            @board.keys.each do |key| puts key end
        when "showall"
            @board.values.each do |list| list.print end
        when "mktodo"
            if @board.key?(label)
                @board[label].add_item(*args)
            else
                puts "No such list with label '#{label}'"
            end
        when "up"
            if @board.key?(label)
                @board[label].up(*(args.map {|el| el.to_i}))
            else
                puts "No such list with label '#{label}'"
            end
        when "down"
            if @board.key?(label)
                @board[label].down(*(args.map {|el| el.to_i}))
            else
                puts "No such list with label '#{label}'"
            end
        when "swap"
            if @board.key?(label)
                @board[label].swap(*(args.map {|el| el.to_i}))
            else
                puts "No such list with label '#{label}'"
            end
        when "sort"
            if @board.key?(label)
                @board[label].sort_by_date!
            else
                puts "No such list with label '#{label}'"
            end
        when "priority"
            if @board.key?(label)
                @board[label].print_priority
            else
                puts "No such list with label '#{label}'"
            end
        when "print"
            if @board.key?(label)
                if args.empty?
                    @board[label].print
                else
                    @board[label].print_full_item(*(args.map {|el| el.to_i}))
                end
            else
                puts "No such list with label '#{label}'"
            end
        when "toggle"
            if @board.key?(label)
                @board[label].toggle(*(args.map {|el| el.to_i}))
            else
                puts "No such list with label '#{label}'"
            end
        when "rm"
            if @board.key?(label)
                @board[label].remove_item(*(args.map {|el| el.to_i}))
            else
                puts "No such list with label '#{label}'"
            end
        when "purge"
            if @board.key?(label)
                @board[label].purge
            else
                puts "No such list with label '#{label}'"
            end
        when "quit"
            return false
        else
            puts "Sorry, that command is not recognized."
        end
        true
    end

    def run 
        while get_command do end
    end
end

board = TodoBoard.new
board.run