require_relative "../view"

module PlayerController
  def PlayerController.turn(game)
    player  = game.player
    enemies = game.current_room.enemies
    
    outcome = player.apply_status_effects
    View.display(outcome) if outcome
    
    return if player.is_dead?

    if game.player.is_frozen?
      View.display_turn_skip_message(player.name)
      player_turn_switcher(game)
      View.wait
      return
    end

    gem = View.gems_menu(player.inventory)

    if gem[:target] == nil
      player_turn_switcher(game)
      View.wait
      return
    elsif gem[:target] == :single
      target_id = View.target_menu(enemies, player)
      if target_id >= 0
        target = enemies[target_id]
        outcome = player.use_gem(gem[:name], target)
      elsif target_id == -1
        outcome = player.use_gem(gem[:name])
      end
    elsif gem[:target] == :aoe
      outcome = player.use_aoe_gem(gem[:name], enemies)
    end

    View.display(outcome)

    player_turn_switcher(game) unless player.is_hasted?
    View.display_room_status(game.current_room.enemies, game.player)
    View.wait()
  end
end

def player_turn_switcher(game)
  unless game.player.is_hasted?
    game.player_turn = false
    game.enemy_turn[:flag] = true
  end
end