require_relative "../view"

module EnemyController
  def EnemyController.turn(game)
    enemy   = game.current_room.enemies[game.enemy_turn[:id]]
    enemies = game.current_room.enemies
    
    return enemy_turn_switcher(game) if enemy.is_dead?
    View.display_room_status(game.current_room.enemies, game.player)
    enemy.reduce_cooldowns

    outcome = enemy.apply_status_effects
    View.display(outcome) if outcome
    return enemy_turn_switcher(game) if enemy.is_dead?

    if enemy.is_frozen?
      View.display_turn_skip_message(enemy.name)
      enemy_turn_switcher game
      View.wait
      return
    end

    if enemy.attack_skill && enemy.attack_skill[:cd] == 0
      outcome = enemy.use_attack_skill(game.player)
    elsif enemy.defense_skill &&
          enemy.defense_skill[:cd] == 0 &&
          game.current_room.get_wounded_id

      target_id = game.current_room.get_wounded_id
      outcome = enemy.use_defense_skill(enemies[target_id])
    else
      outcome = enemy.attack(game.player)
    end

    View.display(outcome)

    return if game.player.is_dead?
  
    enemy_turn_switcher(game)

    View.display_room_status(enemies, game.player)
    View.wait
  end
end

def enemy_turn_switcher(game)
  game.player_turn = true
  enemies = game.current_room.enemies
  id = game.enemy_turn[:id]
  while true
    id += 1
    id = 0 if id == enemies.size
    next if enemies[id].is_dead?
    break
  end
  game.enemy_turn[:id] = id
  game.enemy_turn[:flag] = false
end