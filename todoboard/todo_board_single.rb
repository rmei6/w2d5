require_relative "item"
require_relative "list"

class TodoBoard
    def initialize(label)
        @list = List.new(label)
    end

    def get_command
        print "Enter a command: "
        cmd, *args = gets.chomp.split(" ")
        case cmd
        when "mktodo"
            @list.add_item(*args)
        when "up"
            @list.up(*(args.map {|el| el.to_i}))
        when "down"
            @list.down(*(args.map {|el| el.to_i}))
        when "swap"
            @list.swap(*(args.map {|el| el.to_i}))
        when "sort"
            @list.sort_by_date!
        when "priority"
            @list.print_priority
        when "print"
            if args.empty?
                @list.print
            else
                @list.print_full_item(*(args.map {|el| el.to_i}))
            end
        when "toggle"
            @list.toggle(*(args.map {|el| el.to_i}))
        when "rm"
            @list.remove_item(*(args.map {|el| el.to_i}))
        when "purge"
            @list.purge
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