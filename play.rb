require_relative "./view"
require_relative "./game"
require_relative "./controllers/enemy_controller"
require_relative "./controllers/player_controller"
require_relative "./assets/path_assets"
require_relative "./assets/gem_assets"

def start
  system("clear")
  geode         = GemAssets.geode
  malachite     = GemAssets.malachite
  starter_gems  = {
    geode.name => {gem: geode, quantity: 10},
    malachite.name => {gem: malachite, quantity: 5}
  }
  path = PathAssets.path
  player_name = View.get_player_name
  View.greet(player_name)
  game = Game.new(player_name: player_name, starter_gems: starter_gems, path: path)
  play game
end

def play game
  game.path.each do |level|
    return game_over(game) if game.player.is_dead?
    index = View.display_room_menu(level)
    game.current_room = level[index]
    reset_turns(game)
    battle(game)
  end
end

def battle game
  until game.current_room.is_clear? || game.player.is_dead?
    sleep(0.2)
    if game.player_turn
      PlayerController.turn(game)
    elsif game.enemy_turn[:flag]
      EnemyController.turn(game)
    end
  end

  unless game.player.is_dead?
    game.player.heal(100)
    game.player.add_to_inventory(game.current_room.reward) 
    View.display_room_reward game.current_room.reward
  end
end

def reset_turns(game)
  game.enemy_turn[:id] = 0
  game.enemy_turn[:flag] = false
  game.player_turn = true
end

def game_over game
  choice = View.display_game_over
  case choice
  when "Restart"
    system("clear")
    player_name = game.player.name
    game = Game.new(player_name: player_name, starter_gems: {}, path: PATH)
    play game
  when "Exit"
    View.exit
  end
end

start()