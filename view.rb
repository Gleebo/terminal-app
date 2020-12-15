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
      menu = inventory.map do |k, v|
        {
          name: k.ljust(15, ".") + v[:gem].description,
          value: v[:gem]
        }
      end
      @@prompt.select("Select a gem to use", menu)
    end

    def View.target_menu(targets, player)
      target_names = targets.map do |k, v|
        {name: v.name, hp: v.hp, value: k}
      end
      target_names << {name: player.name, value: -1}
      @@prompt.select("Select target", target_names)
    end

    def View.display_room_status (enemies, player)
      to_display = enemies.map { |v| [v.name, v.hp, stringify_status(v.status)]}
      to_display << [player.name, player.hp, stringify_status(player.status)]
      table = @@table.new(["Character", "HP", "Status"], to_display)
      ascii_table = @@renderer.new(table)
      puts ascii_table.render
    end

    def View.display_turn_skip_message name
      puts "#{name} skips turn because of #{@@pastel.blue("frozen")} status effect"
    end

    def View.display outcome
      puts outcome
    end
end

def stringify_status(status)
  status.reduce("") do |acc, (k, v)|
    acc << "#{k} for #{v[:turns]} #{v[:turns] == 1 ? 'turn' : 'turns'} | "
  end
end
