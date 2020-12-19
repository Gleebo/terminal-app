require "pastel"
require "tty-table"
require "tty-prompt"

module View
  @@pastel    = Pastel.new
  @@table     = TTY::Table
  @@renderer  = TTY::Table::Renderer::ASCII
  @@prompt    = TTY::Prompt.new
  
  def self.get_player_name
    print "\nEnter your name: "
    begin
      gets.chomp
    rescue Interrupt
      quit
    end
  end
  
  def self.greet(name)
    puts "#{name}, Welcome to the world of #{@@pastel.red("G") +
      @@pastel.green("e") +
      @@pastel.bright_green("m")+
      @@pastel.blue("s")}"
    puts "Press Enter to continue"
    gets
    system "clear"
  end

  def self.display_room_reward rewards
    puts "Room clear!\n"
    puts "You got healed for 100hp\n"
    puts "Your reward:"
    rewards.each { |k, v|
      puts "#{k.ljust(20)} x #{v[:quantity]}"
    }
    puts "press Enter to continue"
    gets
    system("clear")
  end
  
  def self.display_room_menu rooms
    menu = rooms.each_with_index.map { |room, index| {name: room.description, value: index } }
    begin
      @@prompt.select("Pick a room to enter", menu)
    rescue TTY::Reader::InputInterrupt
      quit
    end
  end

  def self.gems_menu(inventory)
    menu = inventory.map do |k, v|
      {
        name: "#{k.ljust(15, " ")}x#{v[:quantity].to_s.ljust(7, ".")}#{v[:gem].description}",
        value: {name: k, target: v[:gem].target}
      }
    end
    menu << {name: "Skip turn", value: {name: nil, target: nil}}
    begin
      @@prompt.select("Select a gem to use", menu)
    rescue TTY::Reader::InputInterrupt
      quit
    end
  end

  def self.target_menu(targets, player)
    target_names = targets.each_with_index.map do |target, index|
      {name: target.name, hp: target.hp, value: index}
    end
    target_names << {name: player.name, value: -1}
    begin
      @@prompt.select("Select target", target_names)
    rescue TTY::Reader::InputInterrupt
      quit
    end
  end

  def self.display_room_status (enemies, player)
    to_display = enemies.map { |v| [v.name, v.hp, stringify_status(v.status)]}
    to_display << [player.name, player.hp, stringify_status(player.status)]
    table = @@table.new(["Character", "HP", "Status"], to_display)
    ascii_table = @@renderer.new(table)
    puts ascii_table.render
  end

  def self.display_turn_skip_message name
    puts "#{name} skips turn because of #{@@pastel.blue("frozen")} status effect"
  end

  def self.display outcome
    puts outcome
  end

  def self.wait
    puts "Press any key to continue"
    gets
    system("clear")
  end

  def self.display_game_over
    puts "Game over!\n\n"
    @@prompt.select("Would you like to try again?", ["Restart", "Exit"])
  end

  def self.quit
    puts "\nGoodbye!"
    exit
  end
end

def stringify_status(status)
  arr = status.map do |k, v|
    "#{k} for #{v[:turns]} #{v[:turns] == 1 ? 'turn' : 'turns'}"
  end
  arr.join(" | ")
end
