require "byebug"
class Item
    attr_accessor :title, :description
    attr_reader :deadline, :done
    def self.valid_date?(date)
        months = (1..12).to_a
        days = (1..31).to_a
        digits = (0..9).to_a
        nums = date.split("-")
        return false if nums.length != 3
        return false if nums[0].length != 4 || nums[1].length != 2 || nums[2].length != 2
        #return false if nums[0].to_i > 2022        //only past dates?
        #if nums[0].to_i == 2022
        #    return false if nums[1].to_i > 2 || nums[2].to_i > 10
        #end
        nums[0].chars.each do |char| return false if !digits.include?(char.to_i) end
        return false if !months.include?(nums[1].to_i) || !days.include?(nums[2].to_i)
        true
    end

    def initialize(title,deadline,description)
        raise "Invalid Deadline" if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def deadline=(new_deadline)
        raise "Invalid Deadline" if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end

    def toggle
        @done = !@done
    end
end