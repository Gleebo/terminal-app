require "pastel"
require "tty-table"
require "tty-prompt"

module View
    @@pastel    = Pastel.new
    @@table     = TTY::Table
    @@renderer  = TTY::Table::Renderer::ASCII
    @@prompt    = TTY::Prompt.new
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
        table       = [1,2,3].zip(inventory)
        table       = @@table.new(["#", "Gem"], table)
        ascii_table = @@renderer.new(table)
        puts ascii_table.render
    end

    def View.gems_menu(inventory)
      menu = inventory.map {|k, v| {name: k, value: v[:gem]} }
      @@prompt.select("Select the gem to use", menu)
    end

    def View.target_menu(targets)
      target_names = targets.map { |k, v| {name: "#{v.name} hp: #{v.hp}", value: k} }
      @@prompt.select("Select target", target_names)
    end
end
