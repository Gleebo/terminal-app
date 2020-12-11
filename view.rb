require "pastel"

PASTEL = Pastel.new
module View
    def View.greet(name)
        puts "#{name}, Welcome to the world of #{PASTEL.red("G") + 
                                                 PASTEL.green("e") +
                                                 PASTEL.bright_green("m")+
                                                 PASTEL.blue("s")}"
        
    end

    def View.get_player_name
        print "\nEnter your name: "
        gets.chomp
    end


end