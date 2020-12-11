require "pastel"
require "tty-table"

module View
    @@pastel = Pastel.new
    @@table = TTY::Table
    @@renderer = TTY::Table::Renderer::ASCII
    def View.greet(name)
        puts "#{name}, Welcome to the world of #{@@pastel.red("G") + 
                                                 @@pastel.green("e") +
                                                 @@pastel.bright_green("m")+
                                                 @@pastel.blue("s")}"
    end

    def View.get_player_name
        print "\nEnter your name: "
        gets.chomp
    end

    def View.display_inventory(inventory)
        table = @@table.new([1,2,3], [inventory])
        ascii_table = @@renderer.new(table)
        puts ascii_table.render
    end
end
